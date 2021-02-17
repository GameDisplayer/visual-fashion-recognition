%% Classification of image sent
function classification(image)

 %Load the pre-trained network
    load('resnet101_plus.mat');

    %Resize image for classification
    I = imread(image);
    inputSize=net.Layers(1).InputSize;
    I=imresize(I, inputSize(1:2));

    %Classify the Image
    label = classify(net, I);
    message = "The label predicted is " + char(label(1));

    fileID = fopen('label.txt','w');
    fprintf(fileID,message);
    fclose(fileID);
end
   