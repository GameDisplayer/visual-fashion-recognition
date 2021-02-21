%% KTH-TIPS
%tempdir="C:\Users\Romain\Desktop\Visual\";
%location = fullfile(tempdir,'kth_tips_grey_200x200','KTH_TIPS');
location = '../../FabricsTextureDataset';
Imds = imageDatastore(location,'IncludeSubFolders',true,'FileExtensions','.png','LabelSource','foldernames');

numImages = 810;
perm = randperm(numImages,20);
for np = 1:20
    subplot(4,5,np)
    im = imread(Imds.Files{perm(np)});
    imagesc(im);    
    colormap gray; axis off;
end

%% Texture classification

if isempty(gcp)
    parpool;
end

rng(100)
Imds = imageDatastore(location,'IncludeSubFolders',true,'FileExtensions','.png','LabelSource','foldernames');
Imds = shuffle(Imds);
[trainImds,testImds] = splitEachLabel(Imds,0.8);

countEachLabel(trainImds)

countEachLabel(testImds)

Ttrain = tall(trainImds);
Ttest = tall(testImds);


sn = waveletScattering2('ImageSize',[200 200],'InvarianceScale',150);

trainfeatures = cellfun(@(x)helperScatImages_mean(sn,x),Ttrain,'Uni',0);
testfeatures = cellfun(@(x)helperScatImages_mean(sn,x),Ttest,'Uni',0);

Trainf = gather(trainfeatures);
trainfeaturess = cat(2,Trainf{:});

Testf = gather(testfeatures);
testfeaturess = cat(2,Testf{:});

%% PCA Model and Prediction

model = helperPCAModel(trainfeaturess,30,trainImds.Labels);
predlabels = helperPCAClassifier(testfeaturess,model);

accuracy = sum(testImds.Labels == predlabels)./numel(testImds.Labels)*100

figure
confusionchart(testImds.Labels,predlabels)

%% Save model

texture_classifier = model
save('texture_classifier.mat', 'texture_classifier');
%% test model

image = "../../trainSetWithBlackWhiteBordersCropped/24.jpg";
%im = imread(image);
imageCropped = crop(image);
imageCroppedG = rgb2gray(imageCropped);
figure, imshow(imageCroppedG)

im_feats = helperScatImages_mean(sn,imageCroppedG)
im_feats = gather(im_feats);
imf = cat(2, im_feats(:));

label = helperPCAClassifier(imf,model)
   
%% Test load
net = load('texture_classifier.mat');
class = net.texture_classifier;

sn = waveletScattering2('ImageSize',[200 200],'InvarianceScale',150);
 %I = imread(image);
image = "../../trainSetWithBlackWhiteBordersCropped/24.jpg";
imageCropped = crop(image);
imageCroppedG = rgb2gray(imageCropped);
im_feats = helperScatImages_mean(sn,imageCroppedG);
im_feats = gather(im_feats);
imf = cat(2, im_feats(:));

%Predict
texture = helperPCAClassifier(imf,class);