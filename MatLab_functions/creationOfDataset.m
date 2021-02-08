% In this file, the dataset is created, extracting a part of the "10K
% products" dataset. 
% In order to use this code, it's needed to download the "10K products"
% dataset and to change the path. In this project, the original dataset is
% not provided because of its size.

%% Read the CSV file
T = readtable("C:\Users\Romain\Desktop\Visual Information\PROJECT\Data\train.csv");

%% Set up the train folder
train_folder = "C:\Users\Romain\Desktop\Visual Information\PROJECT\Data\train\train";

%% Creation of the train subset
% By previous observation, the 3 700 first classes are choosed. These
% classes represent fashion items. The final subset is composed of 39 762
% images.

MAXCLASSE = 3699;
if not(isfolder("trainSet"))
    mkdir("trainSet")
end

k=1;
for i=0:MAXCLASSE
    class = T.class == i;
    imagesSelected = T(class,:);
    for j=1:height(imagesSelected)
        im = imread(train_folder + "\" + string(imagesSelected{j,1}));
        file = fullfile('trainSet', [num2str(k) '.jpg']);
        imwrite(im, file);
        k=k+1;
    end
end