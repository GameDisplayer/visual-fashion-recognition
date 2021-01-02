function isBright(image)
    inputImage = imread(image);
    brightness = mean2(inputImage);
    
    if( brightness < 50)
        message = " and dark.";
    elseif (brightness > 175)
        message = " and overexposed.";
    else
        message = " and normal.";
    end
    
    fileID = fopen('messages.txt','a');
    fprintf(fileID,message);
    fclose(fileID);
    
end