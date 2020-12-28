I_bad = imread('blurred.jpg');
I_bad_blur = imgaussfilt(I_bad,2);
I_good = imread('dress.jpg');
I_good_blur = imgaussfilt(I_good,2);

%% BRISQUE
% Calculate the BRISQUE score for each image using the default model, and display the score.
%  Lower values of score reflect better perceptual quality of image
% train a mdel to improve !!!
brisqueI_bad = brisque(I_bad);
fprintf('BRISQUE score for bad image is %0.4f.\n',brisqueI_bad)

brisqueI_bad_blur = brisque(I_bad_blur);
fprintf('BRISQUE score for bad blurred image is %0.4f.\n',brisqueI_bad_blur)

brisqueI_good = brisque(I_good);
fprintf('BRISQUE score for good image is %0.4f.\n',brisqueI_good)

brisqueI_good_blur = brisque(I_good_blur);
fprintf('BRISQUE score for good blurred image is %0.4f.\n\n',brisqueI_good_blur)

%% NIQE
niqeI_bad = niqe(I_bad);
fprintf('NIQE score for bad image is %0.4f.\n',niqeI_bad)

niqeI_good = niqe(I_good);
fprintf('NIQE score for good image is %0.4f.\n\n',niqeI_good)

%% PIQE
piqeI_bad = piqe(I_bad);
fprintf('PIQE score for bad image is %0.4f.\n',piqeI_bad)

piqeI_good = piqe(I_good);
fprintf('PIQE score for good image is %0.4f.\n',piqeI_good)