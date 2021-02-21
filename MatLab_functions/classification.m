%% Classification of image sent
function classification(image)

    added_path = [pwd,'/MatLab_functions/model_saved'];
    addpath(added_path);
    
    added_path2 = [pwd,'/MatLab_functions/color_classification'];
    addpath(added_path2);

    %Load the pre-trained network
    load('resnet101_plus.mat');

    %Resize image for classification
    I = imread(image);
    inputSize=net.Layers(1).InputSize;
    I=imresize(I, inputSize(1:2));

    %Classify the Image
    [label, scores] = classify(net, I);
    correspondanceWithGroups(scores, label(1));
    
    rmpath(added_path);
    rmpath(added_path2);
end
   