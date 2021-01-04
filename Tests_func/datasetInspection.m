%% Read CSV
T = readtable("C:\Users\Romain\Desktop\Visual Information\PROJECT\Data\train.csv");

%% Data 
% histogram(T.group);
% title('Groups');

train_folder = "C:\Users\Romain\Desktop\Visual Information\PROJECT\Data\train\train";


%% Iterate over groups
% count=0;
% for i = 1:height(T)
%     if (T{i,3} == count || T{i,3} == count+1) 
%       close all;
%       a = imread(train_folder + "\" + string(T{i,1}));
%       figure('Name',"Class " + string(T{i,2}) + "; Group " + string(T{i,3})); imshow(a)
%       pause(1);
%       count=count+1
%     end
% end

%% Iterate over classes of same group
% groupl = T.group == 3
% l=sum(groupl)
% NT = T(groupl,:)
% 
% for i = 1:height(NT)
%     close all;
%     a = imread(train_folder + "\" + string(NT{i,1}));
%     figure('Name',"Class " + string(NT{i,2}) + "; Group " + string(NT{i,3})); imshow(a)
%     pause(1);
% end

%% Iterate over images of same classes 
% class = T.class == 7
% l=sum(class)
% NT = T(class,:)
% 
% for i = 1:height(NT)
%     close all;
%     a = imread(train_folder + "\" + string(NT{i,1}));
%     figure('Name',"Class " + string(NT{i,2}) + " " + i + "/" + l); imshow(a)
%     pause(1);
% end

%% Iterate over classes
% count=0;
% for i = 1:height(T)
%     if (T{i,2} == count) 
%       close all;
%       a = imread(train_folder + "\" + string(T{i,1}));
%       figure('Name',"Class " + string(T{i,2})); imshow(a)
%       pause(1);
%       count=count+1
%     end
% end

%% See img of class
% close all
% class = T.class == 3699
% NT = T(class,:)
% a = imread(train_folder + "\" + string(NT{1,1}));
% figure('Name',"Class " + string(NT{1,2})); imshow(a)
