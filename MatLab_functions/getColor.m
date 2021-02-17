%% Classification of image sent
function classification(image)

    %Groups
    groups = ["black", "blue", "green", "orange", "red", "violet", "white", "yellow"];

    %Load the pre-trained network
    load('knn.mat');

    im=imread(image);
    % crop
    [rows, columns, numberOfColorChannels] = size(im);
    cropRows = round(30 * rows / 100);
    cropColumns = round(30 * columns / 100);
    targetSize = [cropRows cropColumns];
    win1 = centerCropWindow2d(size(im),targetSize);
    B1 = imcrop(im,win1);
    figure, imshow(B1)

    %reshape and get color histogram
    im=im2double(B1);
    im=reshape(im, [], 3);
    f = color_histogram(im, Nbin);

    %Predict color
    label = predict(Mdl, f);
    mess = strcat("Is your clothing ", groups(label), " ?");
    
    fileID = fopen('color.txt','w');
    fprintf(fileID, mess);
    fclose(fileID);
end