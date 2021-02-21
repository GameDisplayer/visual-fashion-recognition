%% Load model
%load('knn_google_512.mat');
load('svm.mat');
%% Load Data
%train_folder = "C:\Users\Romain\Desktop\Visual\trainSetWithBlackWhiteBordersCropped";
train_folder = "../../trainSetWithBlackWhiteBordersCropped";
imds=imageDatastore(train_folder, 'FileExtensions','.jpg');

%% Classify all images by color

colors = [];
imgs = [];
n = numel(imds.Files);
for i=1:n
    image=char(imds.Files(i));
    newStr = split(image,'\');
    last = string(newStr(end));
    imageCropped = crop(image);
    % color histogram
    im=im2double(imageCropped);
    im=reshape(im, [], 3);
    f = color_histogram(im, Nbin);
    %predict
    label = predict(Mdl, f);

    %Collect name and color id
    imgs = [imgs; last];
    colors = [colors; label];
end

%% Remember in CSV file

file = [imgs colors];
writematrix(file, 'color.csv')