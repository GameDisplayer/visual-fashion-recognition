function correction(image)
    image = imread(image);
    fileID = fopen('booleanAccepted.txt', 'r');
    read = fscanf(fileID,'%d');
    fclose(fileID);
    added_path = [pwd,'/MatLab_functions/correction'];%/MatLab_functions/correction
    addpath(added_path);
    
    isCorrectedBlur = 1;
    isCorrectedBright = 1;
    isCorrectedNoise = 1;
    if(read(1) == 1)
        isCorrectedBlur = 0;
        imageCorrected = deblur(image);
        b = isBlurry(imageCorrected,15,1);
        if(b == 0)
            image = imageCorrected;
            isCorrectedBlur = 1;
        end
    end
    if(read(2) == 1)
        isCorrectedBright = 0;
        imageCorrected = correctBrightness(image);
        b = isBright(imageCorrected,1);
        if(b == 0)
            image = imageCorrected;
            isCorrectedBright = 1;
        end
    end
    if(read(3) == 1)
        isCorrectedNoise = 0;
        imageCorrected = unNoise(image);
        b = isNoisy(imageCorrected,1);
        if(b == 0)
            image = imageCorrected;
            isCorrectedNoise = 1;
        end
    end
    rmpath(added_path);
    if(isCorrectedBlur == 1 && isCorrectedBright == 1 && isCorrectedNoise == 1)
        imwrite(image, 'Corrected.jpg');
    end
end