function textureRecognition(image)
    %Load the pretrained network
    load('texture_classifier.mat');
    
    %Prepare image
    sn = waveletScattering2('ImageSize',[200 200],'InvarianceScale',150);
    I = imread(image);
    imageCropped = crop(I);
    imageCroppedG = rgb2gray(imageCropped);
    im_feats = helperScatImages_mean(sn,imageCroppedG)
    im_feats = gather(im_feats);
    imf = cat(2, im_feats(:));
    
    %Predict
    texture = helperPCAClassifier(imf,net)
    
    %Write in file
    fileID = fopen('texture.txt','w');
    fprintf(fileID, texture);
    fclose(fileID);
end
