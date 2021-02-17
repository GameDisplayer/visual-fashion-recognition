I = imread('C:\Users\Romain\Desktop\Visual\Data\6355.jpg');
imshow(I);
I = rgb2gray(I);


BW1 = edge(I,'sobel');
BW2 = edge(I,'canny');
figure;
imshowpair(BW1,BW2,'montage')
title('Sobel Filter - Canny Filter');