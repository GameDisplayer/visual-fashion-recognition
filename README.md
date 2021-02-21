# Final project of Visual Information Processing and Management :
**Goal:** The purpose of this project is to allow users to obtain an outfit proposal based on clothes of their choice.
First, using his phone, a user sends a picture to our Telegram Bot. Then, the Bot checks if this image is usable or not. (If it is possible the image is processed to make it usable).
Finally, the user can choose if he wants to obtain clothes of the same style (color and texture) ~~or if he wants to obtain the same kind
of clothes (shoes, bag, etc.)~~.

**Dataset:** The dataset used is a subset of the [Product 10K](https://products-10k.github.io/) dataset. This subset 
is part of the original dataset containing the fashion products (clothes, accessories and shoes) and is
composed of the images belonging to the 50 first groups.
This subset is not provided in this repository because of its size.

## User's manual :
1. Download the [Telegram application](https://telegram.org/apps) on your phone.
2. Launch the *server.py* file (available at the root of this repository) on your computer.
3. On the Telegram application, open a chat with `@FashionViviBot`.
4. Send your picture in the chat.
5. Follow the instructions given by Vivi. 

## How to communicate with our (fabulous) bot ?

- If you need help, please type "Help" or "help" in the chat.
- Be cautious of the keywords specified by our bot and it will work smoothly !

## Process idea :
1. Analyse the image sent (tell if it is recognizable or not and if not try to make it usable)
2. Recognize the clothing (depending on the category of the dataset ie top, bottom, footwear ~~and accessory~~ and kids clothing)
3. Propose a good "outfit" with some interactions with the user (in terms of color or texture)

## Organization of the repository :
- *python_bot-master* : the directory containing the Telegram Bot, provided by [this repository](https://github.com/dros1986/python_bot).
- *MatLab_functions* : the directory containing all the MatLab functions created during the project. 
- *server.py* : the main python file to launch the Telegram bot locally.

### What does contain the code directory ?

- **color_classification** : the directory for the classification of clothes by color
   - *colorClassifier.m* : where the color classification model is trained on [Google-512-dataset](https://cvhci.anthropomatik.kit.edu/~bschauer/datasets/google-512/) 
   - *color_histogram.m* : the function to extract the color histogram of an image
   - *offlineColorClassifier.m* : all the images of our dataset are classified based on our saved model and the results are in **color.csv**
- **correction** : the directory that contains the functions used for the correction of a non-processable image
  - *correctBrightness.m* : aims at correcting the brightness/darkness of an image
  - *deblur.m* : is a function that tries to deblur an image
  - *unNoise.m* : tries to remove the noise on a noisy image
- **model_saved** contains:
  - *svm.mat* : the saved color classifier
  - *texture_classifier.mat* : the saved texture classifier
- **noise_level_estimation** is the directory that contains the function of noise detection
- **preprocessing** is a folder containing the following functions :
  - *blackCrop.m* : takes an image as input and crop the black useless borders
  - *whiteCrop.m* : is doing the same thing as written above but for the white borders
  - *creationOfDataset.m* : is using the two cropping functions to ceate the trainable dataset
-  **texture_classification** contains the files of the texture classifier :
   - *helperPCAClassifier.m* this is the texture classifierfunction that takes as input the wavelet features and the model and predicts the label
   - *helperPCAModel.m* : is the function of the model that we use for the classification of textures
   - *helperScatImages_mean.m* : helps to take the mean of sf features on image
   - *offlineTextureClassifier.m* : here all the images of our dataset are classified based on our saved model and the results are in **texture.csv**
   - *textureClassifier.m* : where the texture classification model is trained on [the Fabrics dataset](https://ibug.doc.ic.ac.uk/resources/fabrics/)
- **transfer_learning** contains :
  - *TransferLearningUsingResnet101.m* : is the transfer learning approach (finetuning on ResNet101) used to classify the clothings by type 
  - *features_extraction.m* : is another transfer learning approach (features extraction with AlexNet) not used because of the poor performances obtained
-  **utility** is a folder containing :
   - *correspondanceWithGroups.m* : a function that aims at making correspondance between the group labels and the "super-groups" i.e {"top", "bottom", "footwear", "kid", "underwear"}
   - *crop.m* is the function used to crop the images (we assume that the clothing is at the center of the image)

Below are the functions that are used directly in the chatbot (in server.py)
- *classification.m* : based on the saved model the input clothing is classified by its type
- *color.csv* : resulting of the offline classification of the dataset clothes based on color (first column the name, second column the label corresponding)
- *correction.m* : the function used to "correct" images if it is not processable 
- *getColor.m* : the function that predicts the color of the clothing
- *isBlurry.m* : the function that detects if the input image is blurry or not
- *isBright.m* : detects if the image is overexposed or too dark
- *isNoisy.m* : function that aims at detecting if an image is too noisy or not
- textureRecognition.m* : where the classification of the clothing is made thanks to the saved model offline
