function [imageCropped] = crop(image)
    
    im = imread(image);
    % crop
    [rows, columns, numberOfColorChannels] = size(im);
    %30% left
    cropRows = round(30 * rows / 100);
    cropColumns = round(30 * columns / 100);
    targetSize = [cropRows cropColumns];
    win1 = centerCropWindow2d(size(im),targetSize);
    imageCropped = imcrop(im,win1);

end