%% Load Data
T = readtable("C:\Users\Romain\Desktop\Visual\train.csv");

%% preparazione dati
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

%% Show random images from datapath
figure;
perm = randperm(100,20);
for i = 1:20
    subplot(4,5,i);
    imshow(imds.Files{perm(i)});
end

%% Image size of model input layer
%Image size of model input layer
inputSize = lgraph.Layers(1).InputSize;

pixelRange = [-30 30];
imageAugmenter = imageDataAugmenter( ...
    'RandXReflection',true, ...
    'RandXTranslation',pixelRange, ...
    'RandYTranslation',pixelRange);
augimdsTrain = augmentedImageDatastore(inputSize(1:2),imdsTrain, ...
    'DataAugmentation',imageAugmenter);
augimdsValidation = augmentedImageDatastore(inputSize(1:2),imdsValidation);

%Training Options
options = trainingOptions('adam', ...
    'InitialLearnRate', 0.0005, ...
    'MaxEpochs',50, ...
    'ValidationFrequency',20, ...
    'ValidationData',augimdsValidation, ...
    'Verbose',false, ...
    'Plots','training-progress');
%Train Model
net = trainNetwork(augimdsTrain,lgraph,options);
%Validation Accuracy
[YPred,scores] = classify(net,augimdsValidation);
accuracy = mean(YPred == imdsValidation.Labels);
%Confusion Matrix
plotconfusion(imdsValidation.Labels,YPred)
%Predict random images
idx = randperm(numel(imdsValidation.Files),16);
figure
for i = 1:16
    subplot(4,4,i)
    I = readimage(imdsValidation,idx(i));
    imshow(I)
    label = YPred(idx(i));
    title(string(label) + ", " + num2str(100*max(scores(idx(i),:)),3) + "%");
end
%Save Model
resnet18 = net;
save resnet18