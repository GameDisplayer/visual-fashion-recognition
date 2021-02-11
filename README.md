# Final project of Visual Information Processing and Management :
**Goal:** The purpose of this project is to allow a user to obtain more information about clothes of his choice.
First, using his phone, the user sends a picture to our Telegram Bot. Then, the Bot checks if this image is usable or not. (If it is possible the image is processed to make it usable).
Finally, the user can choose if he wants to obtain clothes of the same style (color, etc.) or if he wants to obtain the same kind
of clothes (shoes, bag, etc.).

**Dataset:** The dataset used is a subset of the [Product 10K](https://products-10k.github.io/) dataset. This subset 
is part of the original dataset containing the fashion products (clothes, accessories, shoes, etc.) and is
composed of the images belonging to the 3 700 first classes.
This subset is not provided in this repository because of its size.

## User's manual :
1. Download the Telegram application on your phone.
2. Launch the *server.py* file available in this repository on your computer.
3. On the Telegram application, open a chat with @FashionViviBot.
4. Send your picture in the chat.
5. Follow the instructions given by Vivi. 

## Process idea :
1. Analyse the image sent (tell if it is recognizable or not and if not try to make it usable)
2. Recognize the clothing (depending on the category of the dataset ie top, bottom, footwear and accessory)
3. Propose a good "outfit" with some interactions with the user (in terms of color or textures)

## Organization of the repository :
- *python_bot-master* : the directory containing the Telegram Bot, provided by [this GitHub](https://github.com/dros1986/python_bot).
- *MatLab_functions* : the directory containing all the MatLab functions. 
- *server.py* : the main python file.

## Prerequistes :
