clear all
clc
close all


%% HISTOGRAM
Nbin=16;
features=[];
labels=[];
groups = ["black", "blue", "brown", "green", "orange", "pink", "red", "pink", "purple", "white", "yellow"];
tic
for class=1:11
    folder = 'C:\Users\Romain\Desktop\Visual\colorData\' + groups(class)  + '+color\';
    images = [dir(folder + '*.jpg'); dir(folder + '*.png'); dir(folder + '*.jpeg')];
    n = numel(images);
    for i=1:n
        s=images(i).name;
        im=imread(folder + images(i).name);
        %figure, imshow(im)
        %im = rgb2hsv(im);
        im=im2double(im);
        try
            im=reshape(im, [], 3);
            f = color_histogram(im, Nbin);
            features=[features; f];
            labels=[labels; class];
        catch
        end
        
    end
end
toc %measure time

%% TEST
% features_test=[];
% labels_test=[];
% 
% tic
% folder = 'C:\Users\Romain\Desktop\Visual\colorData\testimg\';
% 
% labels_test=[labels_test; class];
% for i=1:95
%     a = [folder  num2str(i)  '.jpg']
%     im=imread([folder  num2str(i)  '.jpg']);
%     %figure, imshow(im)
%     %im = rgb2hsv(im);
%     im=im2double(im);
%     im=reshape(im, [], 3);
%     f = color_histogram(im, Nbin);
%     features_test=[features_test; f];
% end
% toc %measure time


%% Classification
Mdl = fitcknn(features,labels,'OptimizeHyperparameters', {'Distance','NumNeighbors'});

%% Test set
% labels_pred=[];
% 
% tic
% for ns=1:size(features_test,1)
%     
%     label = predict(Mdl,features_test(ns,:));
%     labels_pred=[labels_pred; label];
%     
% end
% toc

%% calcolo performance
% M=confusionmat(labels_test, labels_pred)
% M=M./sum(M,2);
% acc=mean(diag(M))

%% save model

knn_google_512 = Mdl;
save knn_google_512

%% predict

img='C:\Users\Romain\Desktop\Visual\trainSetWithBlackWhiteBordersCropped\17.jpg';
im=imread(img);
%figure, imshow(im)
% crop
[rows, columns, numberOfColorChannels] = size(im);
cropRows = round(30 * rows / 100);
cropColumns = round(30 * columns / 100);
targetSize = [cropRows cropColumns];
win1 = centerCropWindow2d(size(im),targetSize);
B1 = imcrop(im,win1);
figure, imshow(B1)

im=im2double(B1);
im=reshape(im, [], 3);
f = color_histogram(im, Nbin);

label = predict(Mdl, f);
groups(label)