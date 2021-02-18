%% Classification of image sent
function classification(image)

    %Load the pre-trained network
    load('resnet101_plus.mat');

    %Resize image for classification
    I = imread(image);
    inputSize=net.Layers(1).InputSize;
    I=imresize(I, inputSize(1:2));

    %Classify the Image
    [label, scores] = classify(net, I);
    correspondanceWithGroups(scores, label(1));
end
   