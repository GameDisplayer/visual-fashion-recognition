I = imread('C:\Users\Romain\Desktop\Visual\Data\288.jpg');
figure, imshow(I)
title('Or')

[rows, columns, numberOfColorChannels] = size(I);
cropRows = round(60 * rows / 100);
cropColumns = round(60 * columns / 100);
targetSize = [cropRows cropColumns];

win1 = centerCropWindow2d(size(I),targetSize);
B1 = imcrop(I,win1);
figure, imshow(B1)
title('Cropped')

% meanRed = mean2(B1(:,:,1))
% meanGreen = mean2(B1(:,:,2))
% meanBlue = mean2(B1(:,:,3))