clear all
clc
close all


%% HISTOGRAM
Nbin=16;
features=[];
labels=[];
groups = ["black", "blue", "brown", "green","grey", "orange", "pink", "red", "purple", "white", "yellow"];
tic
for class=1:11
    folder = '../../colorData/' + groups(class)  + '+color/';
    images = [dir(folder + '*.jpg'); dir(folder + '*.png'); dir(folder + '*.jpeg')];
    n = numel(images);
    for i=1:n
        s=images(i).name;
        %im=imread(folder + images(i).name);
        %figure, imshow(im)
        %im = rgb2hsv(im);
        %im=im2double(im);
        im=crop(folder + images(i).name);
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
features_test=[];
labels_test=[];

tic
for class=1:11
    folder = '../../colorData/testimg/' + groups(class)  + '/';
    images = [dir(folder + '*.jpg'); dir(folder + '*.png'); dir(folder + '*.jpeg')];
    n = numel(images);
    for i=1:n
        s=images(i).name;
        %im=imread(folder + images(i).name);
        %figure, imshow(im)
        %im = rgb2hsv(im);
        %im=im2double(im);
        im=crop(folder + images(i).name);
        im=im2double(im);
        try
            im=reshape(im, [], 3);
            f = color_histogram(im, Nbin);
            features_test=[features_test; f];
            labels_test=[labels_test; class];
        catch
        end
    end
end
toc %measure time


%% Classification
%Mdl = fitcknn(features,labels,'OptimizeHyperparameters',{'Distance','NumNeighbors'});
%0.89
Mdl = fitcecoc(features,labels); %0.93

%% Test set
labels_pred=[];

tic
for ns=1:size(features_test,1)
    
    label = predict(Mdl,features_test(ns,:));
    labels_pred=[labels_pred; label];
    
end
toc

%% calcolo performance
M=confusionmat(labels_test, labels_pred)
M=M./sum(M,2);
acc=mean(diag(M))

%% save model

%knn_google_512 = Mdl;
%save knn_google_512
svm = Mdl;
save svm

%% predict

img='../../trainSetWithBlackWhiteBordersCropped/99.jpg';
croppedImage = crop(img);
imshow(croppedImage);

% color histogram
im=im2double(croppedImage);
im=reshape(im, [], 3);
f = color_histogram(im, Nbin);

label = predict(Mdl, f);
groups(label)