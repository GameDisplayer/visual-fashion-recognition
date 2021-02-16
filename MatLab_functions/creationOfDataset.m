% In this file, the dataset is created, extracting a part of the "10K
% products" dataset. 
% In order to use this code, it's needed to download the "10K products"
% dataset and to change the path. In this project, the original dataset is
% not provided because of its size.

%% Read the CSV file
T = readtable("C:\Users\Romain\Desktop\Visual\train.csv");

%% Set up the train folder
train_folder = "C:\Users\Romain\Desktop\Visual\trainSetWithBlackBordersCropped";

%% Creation of the train subset
% By previous observation, the 50 first groups are choosed (Group 1 to 
% group 50). These groups represent fashion items. The final subset is 
% composed of 27 507 images.

MAXGROUP = 50;
if not(isfolder("trainSet"))
    mkdir("trainSet")
end

for i=1:MAXGROUP
    grp = T.group == i;
    imagesSelected = T(grp,:);
    for j=1:height(imagesSelected)
        im = imread(train_folder + "\" + string(imagesSelected{j,1}));
        file = fullfile('trainSet', string(imagesSelected{j,1}));
        imwrite(im, file);
    end
end

%% Creation of test group
% In this part, we use all the pictures of the group 0 in order to use them
% for test from the Telegram Bot. In fact, the pictures of the groups 0
% seem to belong to a big number of categories, is composed of 718 images.

if not(isfolder("group0Set"))
    mkdir("group0Set")
end

grp = T.group == 0;
imagesSelected = T(grp,:);
for j=1:height(imagesSelected)
    im = imread(train_folder + "\" + string(imagesSelected{j,1}));
    file = fullfile('group0Set', [num2str(j) '.jpg']);
    imwrite(im, file);
end