# Final project of Visual Information Processing and Management :
**Goal:** The purpose of this project is to allow an user to obtain more information about clothes of his choice.
Using his phone, the user send a picture to our Telegram Bot. Then the Bot check if this image is usable and after this 
the user can choose if he want to obtain clothes of the same styles (color, etc.) or if he want to obtain the same kind
of clothes (shoes, bag, etc.).

**Dataset:** The dataset used is a subset of the [Product 10K](https://products-10k.github.io/) dataset. This subset 
consist in the part of the original dataset containing the fashion products (clothes, accessories, shoes, etc.) and is
composed of the images belonging to the 3 700 first classes of the original dataset.
This subset is not provided in this repository because of its size.

## User's manual :
1. Download the Telegram application on your phone.
2. Launch the *server.py* file available in this repository on your computer.
3. On the Telegram application, open a chat with @FashionViviBot.
4. Send your picture in the chat.
5. Follow the instruction gived by Vivi. 

## Process idea :
1. Analyse image (tell if recognizable or not)
2. Recognize the clothing (depending on the category of the dataset ie top, bottom, footwear and acc)
3. Propose a good "outfit" with some interactions with the user (in terms of color or textures)

## Organization of the repository :
- *python_bot-master* : the directory containing the Telegram Bot, provided by [this GitHub](https://github.com/dros1986/python_bot).
- *MatLab_functions* : the directory containing all the MatLab functions. 
- *server.py* : the main python file.

## Prerequistes :