%% Load pre-trained model
net = alexnet;
%analyzeNetwork(net)
inputSize = net.Layers(1).InputSize;
layer = 'fc7';

%% Load table
T = readtable("../../train.csv");

%% Extraction training features
MAXGROUP = 50;

imdir = '../../trainSet/';
feat_tr= [];
labels_tr = [];
Nim4tr = 70;
tic
for group=1:MAXGROUP
    grp = T.group == group;
    imagesSelected = T(grp,:);
    numImTr = ceil(height(imagesSelected)*(Nim4tr/100));
    for nimage=1:numImTr
        im = double(imread(imdir + string(imagesSelected{nimage,1})));
        im = imresize(im, inputSize(1:2));
        feat_tmp = activations(net, im, layer, 'OutputAs', 'rows');
        feat_tr = [feat_tr; feat_tmp];
        labels_tr = [labels_tr; group];
    end
end
toc

%% Extraction validation features
feat_val=[];
labels_val=[];
Nim4val = floor((100 - Nim4tr)/2);
tic
for group=1:MAXGROUP
    grp = T.group == group;
    imagesSelected = T(grp,:);
    numImTr = ceil(height(imagesSelected)*(Nim4tr/100));
    numImVal = ceil(height(imagesSelected)*(Nim4val/100));
    if (numImTr+1)+numImVal <= height(imagesSelected)
        max = (numImTr+1)+numImVal;
    else
        max = height(imagesSelected);
    end
    for nimage=numImTr+1:max
        im = double(imread(imdir + string(imagesSelected{nimage,1})));
        im = imresize(im, inputSize(1:2));
        feat_tmp = activations(net, im, layer, 'OutputAs', 'rows');
        feat_val = [feat_val; feat_tmp];
        labels_val = [labels_val; group];
    end
end
toc

%% Extraction test features
feat_te=[];
labels_te=[];
tic
for group=1:MAXGROUP
    grp = T.group == group;
    imagesSelected = T(grp,:);
    numImTr = ceil(height(imagesSelected)*(Nim4tr/100));
    numImVal = ceil(height(imagesSelected)*(Nim4val/100));
    for nimage=(numImTr+numImVal)+1:height(imagesSelected)
        im = double(imread(imdir + string(imagesSelected{nimage,1})));
        im = imresize(im, inputSize(1:2));
        feat_tmp = activations(net, im, layer, 'OutputAs', 'rows');
        feat_te = [feat_te; feat_tmp];
        labels_te = [labels_te; group];
    end
end
toc

%% Features normalization
feat_tr=feat_tr./sqrt(sum(feat_tr.^2,2));
feat_val=feat_val./sqrt(sum(feat_val.^2,2));
feat_te=feat_te./sqrt(sum(feat_te.^2,2));

labels_tr = categorical(labels_tr, 1:MAXGROUP);
labels_val = categorical(labels_val, 1:MAXGROUP);
labels_te = categorical(labels_te, 1:MAXGROUP);

%% Creation of new model
model = [
    featureInputLayer(4096) %<-- number of features
    
    gruLayer(100)
    gruLayer(50)
    fullyConnectedLayer(MAXGROUP)
    softmaxLayer
    classificationLayer];

%% Training
options = trainingOptions('adam', ...
    'InitialLearnRate',1e-4, ...
    'SquaredGradientDecayFactor',0.99, ...
    'MaxEpochs',50, ...
    'ValidationData',{feat_val, labels_val}, ...
    'ValidationFrequency',20, ...
    'ValidationPatience', 10, ...
    'Verbose',false, ...
    'Plots','training-progress');

modelTrain = trainNetwork(feat_tr, labels_tr, model, options);

%% Prediction
YPred = classify(modelTrain,feat_te);

accuracy = sum(YPred == labels_te)/numel(labels_te)