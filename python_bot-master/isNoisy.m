function isNoisy(image)
    inputImage = imread(image);
    inputImage = im2double(inputImage);
    
    added_path = [pwd,'/noise_level_estimation']; %change to: added_path = '/path' for your required path
    addpath(added_path);
    
    [nl th num] = NoiseLevel(inputImage);
    
    if (nl > 0.05)
        message = " and noisy."
        bool = 1;
    else
        message = " and not noisy."
        bool = 0;
    end
    
    fileID = fopen('messages.txt','a');
    fprintf(fileID,message);
    fclose(fileID);
   
    fileID2 = fopen('booleanAccepted.txt', 'a');
    fprintf(fileID2, '%5d', bool);
    fclose(fileID2);
    
    rmpath(added_path);
end
