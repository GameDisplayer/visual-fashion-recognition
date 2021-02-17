function debluredImage = deblur(image)
    PSF = fspecial('gaussian',5,0.7);
    debluredImage = deconvblind(image,PSF);
end