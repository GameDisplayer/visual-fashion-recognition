function isN = isNoisy(image, insideFunc)
    if(insideFunc==0)
        inputImage = imread(image);
        inputImage = im2double(inputImage);
    else
        inputImage = im2double(image);
    end
    
    added_path = [pwd,'/MatLab_functions/noise_level_estimation']; %/MatLab_functions/noise_level_estimation
    addpath(added_path);
    
    [nl th num] = NoiseLevel(inputImage);
    
    if (nl > 0.05)
        message = " and noisy.";
        bool = 1;
    else
        message = " and not noisy.";
        bool = 0;
    end
    
    if(insideFunc == 0)
        fileID = fopen('messages.txt','a');
        fprintf(fileID,message);
        fclose(fileID);
   
        fileID2 = fopen('booleanAccepted.txt', 'a');
        fprintf(fileID2, '%5d', bool);
        fclose(fileID2);
    end
    
    rmpath(added_path);
    isN = bool;
end
