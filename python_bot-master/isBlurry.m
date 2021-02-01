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
        bool = 1;
    else
        message="The image is not blurry";
        bool = 0;
    end
    
    fileID = fopen('messages.txt','w');
    fprintf(fileID,message);
    fclose(fileID);
    
    fileID2 = fopen('booleanAccepted.txt', 'w');
    fprintf(fileID2, '%5d', bool);
    fclose(fileID2);

end
