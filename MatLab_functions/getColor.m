%% Classification of image sent
function classification(image)

    %Groups
    groups = ["black", "blue", "brown", "green", "orange", "pink", "red", "pink", "purple", "white", "yellow"];
    
    added_path = [pwd,'/MatLab_functions/model_saved'];
    addpath(added_path);
    
    added_path2 = [pwd,'/MatLab_functions/color_classification'];
    addpath(added_path2);
    
    added_path3 = [pwd,'/MatLab_functions/utility'];
    addpath(added_path3);
    
    %Load the pre-trained network
    load('svm.mat');

    B1 = crop(image);
%     im=imread(image);
%     % crop
%     [rows, columns, numberOfColorChannels] = size(im);
%     cropRows = round(30 * rows / 100);
%     cropColumns = round(30 * columns / 100);
%     targetSize = [cropRows cropColumns];
%     win1 = centerCropWindow2d(size(im),targetSize);
%     B1 = imcrop(im,win1);
%     figure, imshow(B1)

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
    
    fileID2 = fopen('colorNum.txt','w');
    fprintf(fileID2, num2str(label));
    fclose(fileID2);
    
    rmpath(added_path);
    rmpath(added_path2);
    rmpath(added_path3);
end