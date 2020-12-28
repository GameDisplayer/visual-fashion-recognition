%% HSV
% hsvI_dark = rgb2hsv(I_dark); 
% brightness_dark = hsvI_dark(:, 3)
% 
% hsvI_bright = rgb2hsv(I_bright);
% brightness_bright = hsvI_bright(:, 3)
% 
% hsvI_normal = rgb2hsv(I_normal);
% brightness_normal = hsvI_normal(:, 3)


%% Mean of image
function [brightness, message] = isBright(image)
    inputImage = imread(image);
    brightness = mean2(inputImage);
    
    if( brightness < 50)
        message = "dark";
    elseif (brightness > 175)
        message = "overexposed";
    else
        message = "normal";
    end
    
end

%[brightness, message] = isBright('./overExpImgs/2.jpg')

