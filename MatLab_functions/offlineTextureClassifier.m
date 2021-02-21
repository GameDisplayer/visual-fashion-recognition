%% Load model
% load('texture_classifier.mat');

%% Load data
train_folder = "../../trainSetWithBlackWhiteBordersCropped";
imds=imageDatastore(train_folder, 'FileExtensions','.jpg');

%% Classify all images by texture
textures = [];
imgs = [];
n = numel(imds.Files);
for i=1:n
    image=char(imds.Files(i));
    newStr = split(image,'\');
    last = string(newStr(end))
    texture = textureRecognition(image);

    %Collect name and texture
    imgs = [imgs; last];
    textures = [textures; texture];
end

%% Remember in csv file
file = [imgs textures];
writematrix(file, 'texture.csv')