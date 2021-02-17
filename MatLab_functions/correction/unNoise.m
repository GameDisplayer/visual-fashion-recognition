function imageUnNoise = unNoise(image)
    imageUnNoise = imgaussfilt(image,0.9);
end