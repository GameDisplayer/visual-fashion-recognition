%% Load Data
T = readtable("C:\Users\Romain\Desktop\Visual\train.csv");
indir = "C:\Users\Romain\Desktop\Visual\trainSetWithBlackWhiteBordersCropped";
imds=imageDatastore(indir);

labels=[];
for ii=1:size(imds.Files,1)
    name=imds.Files{ii,1};
    [p,n,ex]=fileparts(name);
    l=T(str2double(n), :);
    class=l.group;
    labels=[labels; class];
end
labels=categorical(labels);
imds=imageDatastore(indir,'labels',labels);

%% Split the data into 70% training and 30% validation
[imdsTrain,imdsValidation] = splitEachLabel(imds,0.7,'randomized');

%% Load Pretrained Network
net = resnet101;

%analyzeNetwork(net)

net.Layers(1)
inputSize = net.Layers(1).InputSize;

%% Replace Final Layers

if isa(net,'SeriesNetwork') 
  lgraph = layerGraph(net.Layers); 
else
  lgraph = layerGraph(net);
end 

[learnableLayer,classLayer] = findLayersToReplace(lgraph);
[learnableLayer,classLayer]

numClasses = numel(categories(imdsTrain.Labels)); %50

if isa(learnableLayer,'nnet.cnn.layer.FullyConnectedLayer')
    newLearnableLayer = fullyConnectedLayer(numClasses, ...
        'Name','new_fc', ...
        'WeightLearnRateFactor',10, ...
        'BiasLearnRateFactor',10);
    
elseif isa(learnableLayer,'nnet.cnn.layer.Convolution2DLayer')
    newLearnableLayer = convolution2dLayer(1,numClasses, ...
        'Name','new_conv', ...
        'WeightLearnRateFactor',10, ...
        'BiasLearnRateFactor',10);
end

lgraph = replaceLayer(lgraph,learnableLayer.Name,newLearnableLayer);


newClassLayer = classificationLayer('Name','new_classoutput');
lgraph = replaceLayer(lgraph,classLayer.Name,newClassLayer);

figure('Units','normalized','Position',[0.3 0.3 0.4 0.4]);
plot(lgraph)
ylim([0,10])

%% Freeze Initial Layers

layers = lgraph.Layers;
connections = lgraph.Connections;

layers(1:10) = freezeWeights(layers(1:10));
lgraph = createLgraphUsingConnections(layers,connections);

%% Train Network

pixelRange = [-30 30];
scaleRange = [0.9 1.1];
imageAugmenter = imageDataAugmenter( ...
    'RandXReflection',true, ...
    'RandXTranslation',pixelRange, ...
    'RandYTranslation',pixelRange, ...
    'RandXScale',scaleRange, ...
    'RandYScale',scaleRange);
augimdsTrain = augmentedImageDatastore(inputSize(1:2),imdsTrain, ...
    'DataAugmentation',imageAugmenter);

augimdsValidation = augmentedImageDatastore(inputSize(1:2),imdsValidation);

miniBatchSize = 10;
valFrequency = floor(numel(augimdsTrain.Files)/miniBatchSize);
options = trainingOptions('sgdm', ...
    'MiniBatchSize',miniBatchSize, ...
    'MaxEpochs',6, ...
    'InitialLearnRate',5e-4, ...
    'Shuffle','every-epoch', ...
    'ValidationData',augimdsValidation, ...
    'ValidationFrequency',valFrequency, ...
    'ValidationPatience',3, ...
    'Verbose',false, ...
    'Plots','training-progress');

%% Let's go

net = trainNetwork(augimdsTrain,lgraph,options);

%% Classify Validation Images

[YPred,probs] = classify(net,augimdsValidation);
accuracy = mean(YPred == imdsValidation.Labels)

%% Display images
idx = randperm(numel(imdsValidation.Files),4);
figure
for i = 1:4
    subplot(2,2,i)
    I = readimage(imdsValidation,idx(i));
    imshow(I)
    label = YPred(idx(i));
    title(string(label) + ", " + num2str(100*max(probs(idx(i),:)),3) + "%");
end

%% Save the model

resnet101_plus = net;
save resnet101_plus

%% Confusion matrix
C = confusionmat(imdsValidation.Labels,YPred)
figure, confusionchart(C)