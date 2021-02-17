I = imread('C:\Users\Romain\Desktop\Visual\trainSet\903.jpg');
figure, imshow(I)
title('Or')
grayImage = min(I, [], 3);
binaryImage = grayImage > 10; 
figure, imshow(binaryImage)
binaryImage = bwareafilt(binaryImage, 1);
[rows, columns] = find(binaryImage);
row1 = min(rows);
row2 = max(rows);
col1 = min(columns);
col2 = max(columns);
% Crop
croppedImage = I(row1:row2, col1:col2, :);
figure, imshow(croppedImage)
