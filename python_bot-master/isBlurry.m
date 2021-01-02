%Blur detection with Laplacian kernel
function isBlurry(image, threshold)
    inputImage = imread(image);
    inputImage = rgb2gray(inputImage);

%     kernel = -1 * ones(3);
%     kernel(2,2) = 8;  % Now kernel = [-1,-1,-1; -1,8,-1; -1,-1,-1]
    kernel = [0 1 0; 1 -4 1; 0 1 0];
    output = conv2(double(inputImage), kernel, 'same');
    %imshow(output)
    var = std(output(:));

    if (var < threshold) %21 à affiner
        message="The image is blurry";
    else
        message="The image is not blurry";
    end
    
    fileID = fopen('messages.txt','w');
    fprintf(fileID,message);
    fclose(fileID);

end
