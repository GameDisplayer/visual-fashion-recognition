function done = correction(image)
    image = imread(image);
    fileID = fopen('booleanAccepted.txt', 'r');
    read = fscanf(fileID,'%d');
    fclose(fileID);
    added_path = [pwd,'/MatLab_functions/correction'];
    isCorrected = 0;
    if(read(1) == 1)
        imageCorrected = deblur(image);
        b = isBlurry(imageCorrected,15,1);
        if(b == 0)
            image = imageCorrected;
            isCorrected = 1;
        end
    end
    if(read(2) == 1)
        imageCorrected = correctBrightness(image);
        b = isBright(imageCorrected,1);
        if(b == 0)
            image = imageCorrected;
            isCorrected = 1;
        end
    end
    if(read(3) == 1)
        imageCorrected = unNoise(image);
        b = isNoisy(imageCorrected,1);
        if(b == 0)
            image = imageCorrected;
            isCorrected = 1;
        end
    end
    rmpath(added_path);
    if(isCorrected == 1)
        save(image);
    end
    done = isCorrected;
end