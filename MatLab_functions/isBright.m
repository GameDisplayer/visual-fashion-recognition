function isB = isBright(image, insideFunc)
    if(insideFunc==0)
        inputImage = imread(image);
        brightness = mean2(inputImage);
    else
        brightness = mean2(image);
    end
    
    if( brightness < 50)
        message = ", dark";
        bool = 1;
    elseif (brightness > 175)
        message = ", overexposed";
        bool = 1;
    else
        message = ", normal";
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
    
    isB = bool;
    
end