
figure, displayHist('C:\Users\Romain\Desktop\Visual\Data\1.jpg')
figure, displayHist('C:\Users\Romain\Desktop\Visual\Data\2.jpg')
figure, displayHist('C:\Users\Romain\Desktop\Visual\Data\3.jpg')




function displayHist(image)
    image = imread(image);
    %Split into RGB Channels
    Red = image(:,:,1);
    Green = image(:,:,2);
    Blue = image(:,:,3);
    %Get histValues for each channel
    [yRed, x] = imhist(Red);
    [yGreen, x] = imhist(Green);
    [yBlue, x] = imhist(Blue);
    %Plot them together in one plot
    plot(x, yRed, 'Red', x, yGreen, 'Green', x, yBlue, 'Blue')
end