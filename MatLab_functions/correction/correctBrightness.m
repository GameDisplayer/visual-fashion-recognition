function imageBrighted = correctBrightness(image)
    brightness = mean2(image);
    
    if( brightness < 50)
        gamma = 0;
    elseif (brightness > 175)
        gamma = 2;
    end

    imageBrighted = imadjust(image, [],[], gamma);    
end