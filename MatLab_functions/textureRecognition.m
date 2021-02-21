function texture = textureRecognition(image, inFunction)
    added_path = [pwd,'/MatLab_functions/model_saved'];
    addpath(added_path);
    
    added_path2 = [pwd,'/MatLab_functions/texture_classification'];
    addpath(added_path2);
    
    added_path3 = [pwd,'/MatLab_functions/utility'];
    addpath(added_path3);
    
    %Load the pretrained network
    net = load('texture_classifier.mat');
    net = net.texture_classifier;
    
    %Prepare image
    sn = waveletScattering2('ImageSize',[200 200],'InvarianceScale',150);
    %I = imread(image);
    imageCropped = crop(image);
    imageCroppedG = rgb2gray(imageCropped);
    im_feats = helperScatImages_mean(sn,imageCroppedG);
    im_feats = gather(im_feats);
    imf = cat(2, im_feats(:));
    
    text = helperPCAClassifier(imf,net);
    
    txtStr = cellstr(text);
    txtStr = txtStr{1,1};
    
    if(inFunction == 0)
        %Write in file
        fileID = fopen('texture.txt','w');
        textToWrite = strcat("Is your cloth in ", txtStr, "?");
        fprintf(fileID, textToWrite);
        fclose(fileID);
        
        fileID2 = fopen('textureVal.txt','w');
        fprintf(fileID2, txtStr);
        fclose(fileID2);
    end
    
    rmpath(added_path);
    rmpath(added_path2);
    rmpath(added_path3);
    
    %Predict
    texture = text;
end
