%Crop black borders of image
function [croppedImage] = blackCrop(image)
    grayImage = min(image, [], 3);
    binaryImage = grayImage > 10; 
    binaryImage = bwareafilt(binaryImage, 1);
    [rows, columns] = find(binaryImage);
    row1 = min(rows);
    row2 = max(rows);
    col1 = min(columns);
    col2 = max(columns);
    % Crop
    croppedImage = image(row1:row2, col1:col2, :);
end