import os, sys, platform, subprocess
import os.path
from os import path
import pandas as pd
import random

os.chdir(os.getcwd())
bot_dir = 'python_bot-master'
sys.path.append(bot_dir)

from Updater import Updater

def outfitSameColor(bot, chat_id):
    global matlab_function_dir
    global group
    global color

    image_dir = "..\\trainSet\\"
    
    kid = [1, 4, 8, 15, 22];
    top = [2, 3, 4, 5, 6, 7, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21];
    bottom = [23, 24, 25, 28, 29, 30, 31, 32, 33, 34];
    underwear = [26, 27];
    footwear = [35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50];

    groupChoice = []
    if group in kid:
        groupNot = top + bottom + underwear + footwear
        groupChoice.append(random.choice(kid))
    elif group in top:
        groupNot = top + kid
        groupChoice.append(random.choice(bottom))
        groupChoice.append(random.choice(underwear))
        groupChoice.append(random.choice(footwear))
    elif group in bottom:
        groupNot = bottom + kid
        groupChoice.append(random.choice(top))
        groupChoice.append(random.choice(underwear))
        groupChoice.append(random.choice(footwear))
    elif group in underwear:
        groupNot = underwear + kid
        groupChoice.append(random.choice(bottom))
        groupChoice.append(random.choice(top))
        groupChoice.append(random.choice(footwear))
    else:
        groupNot = footwear + kid
        groupChoice.append(random.choice(bottom))
        groupChoice.append(random.choice(underwear))
        groupChoice.append(random.choice(top))

    dataByColor = pd.read_csv(matlab_function_dir + '\\color.csv',header=0, 
            names=['image', 'color'])

    imageOfRightColor = dataByColor.loc[dataByColor['color']==color]

    groups = pd.read_csv('..\\train.csv')
    imageOfRightGroup = groups.loc[~groups['group'].isin(groupNot)]

    selectedImage = imageOfRightGroup.loc[imageOfRightGroup['name'].isin(imageOfRightColor['image'])]
    nameSelectedImages = []
    for i in groupChoice:
        if i in selectedImage['group'].tolist():
            tmp = selectedImage.loc[selectedImage['group']==i]
            imChoosed = tmp.sample()
            nameImChoosed = imChoosed.iloc[0]['name']
            nameSelectedImages.append(str(nameImChoosed))

    if len(nameSelectedImages) > 0:
        for j in range(len(nameSelectedImages)-1):
            bot.sendImage(chat_id, image_dir + nameSelectedImages[j], "")

        bot.sendImage(chat_id, image_dir + nameSelectedImages[-1], "I hope you like this outfit! See you soon!")
        Last_message_send = ""
    else:
        bot.sendMessage(chat_id, "I'm sorry, but I don't find a good outfit. Please try with a new image !")
        Last_message_send = "Please, try a new image!"

def outfitSameTexture(bot, chat_id):
    global matlab_function_dir
    global group
    global texture

    image_dir = "..\\trainSet\\"
    
    kid = [1, 4, 8, 15, 22];
    top = [2, 3, 4, 5, 6, 7, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21];
    bottom = [23, 24, 25, 28, 29, 30, 31, 32, 33, 34];
    underwear = [26, 27];
    footwear = [35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50];

    groupChoice = []
    if group in kid:
        groupNot = top + bottom + underwear + footwear
        groupChoice.append(random.choice(kid))
    elif group in top:
        groupNot = top + kid
        groupChoice.append(random.choice(bottom))
        groupChoice.append(random.choice(underwear))
        groupChoice.append(random.choice(footwear))
    elif group in bottom:
        groupNot = bottom + kid
        groupChoice.append(random.choice(top))
        groupChoice.append(random.choice(underwear))
        groupChoice.append(random.choice(footwear))
    elif group in underwear:
        groupNot = underwear + kid
        groupChoice.append(random.choice(bottom))
        groupChoice.append(random.choice(top))
        groupChoice.append(random.choice(footwear))
    else:
        groupNot = footwear + kid
        groupChoice.append(random.choice(bottom))
        groupChoice.append(random.choice(underwear))
        groupChoice.append(random.choice(top))

    dataByText = pd.read_csv(matlab_function_dir + '\\texture.csv',header=0, 
            names=['image', 'texture'])

    imageOfRightText = dataByText.loc[dataByText['texture']==texture]

    groups = pd.read_csv('..\\train.csv')
    imageOfRightGroup = groups.loc[~groups['group'].isin(groupNot)]

    selectedImage = imageOfRightGroup.loc[imageOfRightGroup['name'].isin(imageOfRightText['image'])]
    nameSelectedImages = []
    for i in groupChoice:
        if i in selectedImage['group'].tolist():
            tmp = selectedImage.loc[selectedImage['group']==i]
            imChoosed = tmp.sample()
            nameImChoosed = imChoosed.iloc[0]['name']
            nameSelectedImages.append(str(nameImChoosed))

    if len(nameSelectedImages) > 0:
        for j in range(len(nameSelectedImages)-1):
            bot.sendImage(chat_id, image_dir + nameSelectedImages[j], "")

        bot.sendImage(chat_id, image_dir + nameSelectedImages[-1], "I hope you like this outfit! See you soon!")
        Last_message_send = ""
    else:
        bot.sendMessage(chat_id, "I'm sorry, but I don't find a good outfit. Please try with a new image !")
        Last_message_send = "Please, try a new image!"

def outfitBoth(bot, chat_id):
    global matlab_function_dir
    global group
    global color
    global texture

    image_dir = "..\\trainSet\\"
    
    kid = [1, 4, 8, 15, 22];
    top = [2, 3, 4, 5, 6, 7, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21];
    bottom = [23, 24, 25, 28, 29, 30, 31, 32, 33, 34];
    underwear = [26, 27];
    footwear = [35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50];

    groupChoice = []
    if group in kid:
        groupNot = top + bottom + underwear + footwear
        groupChoice.append(random.choice(kid))
    elif group in top:
        groupNot = top + kid
        groupChoice.append(random.choice(bottom))
        groupChoice.append(random.choice(underwear))
        groupChoice.append(random.choice(footwear))
    elif group in bottom:
        groupNot = bottom + kid
        groupChoice.append(random.choice(top))
        groupChoice.append(random.choice(underwear))
        groupChoice.append(random.choice(footwear))
    elif group in underwear:
        groupNot = underwear + kid
        groupChoice.append(random.choice(bottom))
        groupChoice.append(random.choice(top))
        groupChoice.append(random.choice(footwear))
    else:
        groupNot = footwear + kid
        groupChoice.append(random.choice(bottom))
        groupChoice.append(random.choice(underwear))
        groupChoice.append(random.choice(top))

    dataByText = pd.read_csv(matlab_function_dir + '\\texture.csv',header=0, 
            names=['image', 'texture'])

    imageOfRightText = dataByText.loc[dataByText['texture']==texture]

    dataByColor = pd.read_csv(matlab_function_dir + '\\color.csv',header=0, 
            names=['image', 'color'])

    imageOfRightColor = dataByColor.loc[dataByColor['color']==color]


    groups = pd.read_csv('..\\train.csv')
    imageOfRightGroup = groups.loc[~groups['group'].isin(groupNot)]

    selectedImage = imageOfRightGroup.loc[imageOfRightGroup['name'].isin(imageOfRightText['image']) & imageOfRightGroup['name'].isin(imageOfRightColor['image'])]
    nameSelectedImages = []
    for i in groupChoice:
        if i in selectedImage['group'].tolist():
            tmp = selectedImage.loc[selectedImage['group']==i]
            imChoosed = tmp.sample()
            nameImChoosed = imChoosed.iloc[0]['name']
            nameSelectedImages.append(str(nameImChoosed))

    if len(nameSelectedImages) > 0:
        for j in range(len(nameSelectedImages)-1):
            bot.sendImage(chat_id, image_dir + nameSelectedImages[j], "")

        bot.sendImage(chat_id, image_dir + nameSelectedImages[-1], "I hope you like this outfit! See you soon!")
        Last_message_send = ""
    else:
        bot.sendMessage(chat_id, "I'm sorry, but I don't find a good outfit. Please try with a new image !")
        Last_message_send = "Please, try a new image!"    

def classifyClothes(bot, message, chat_id, filename):
    global Last_message_send
    global cur_dir
    global matlab_function_dir
    global matlab_cmd
    global group
    
    #Set command to start matlab script "classification.m"
    cmd_classification = matlab_cmd + " -nodesktop -nosplash -wait -r \"addpath(\'" + matlab_function_dir + "\'); classification(\'" + filename + "\'); quit\""
    #Launch command
    subprocess.call(cmd_classification,shell=True)

    f3 = open(cur_dir + "\\label.txt", "r")
    label = f3.read()
    bot.sendMessage(chat_id, label)
    Last_message_send = "Check clothes"
    f3.close()

    f3b = open(cur_dir + "\\labelNum.txt", "r")
    group = int(f3b.read())
    f3b.close()
    

def detectColor(bot, message, chat_id, filename):
    global Last_message_send
    global cur_dir
    global matlab_function_dir
    global matlab_cmd
    global color

    #Set command to start matlab script "getColor.m"
    cmd_classification = matlab_cmd + " -nodesktop -nosplash -wait -r \"addpath(\'" + matlab_function_dir + "\'); getColor(\'" + filename + "\'); quit\""
    #Launch command
    subprocess.call(cmd_classification,shell=True)

    f4 = open(cur_dir + "\\color.txt", "r")
    colorString = f4.read()
    bot.sendMessage(chat_id, colorString)
    Last_message_send = "Check color"
    f4.close()

    f4b = open(cur_dir + "\\colorNum.txt", "r")
    color = int(f4b.read())
    f4b.close()
    

def detectTexture(bot, message, chat_id, filename):
    global Last_message_send
    global cur_dir
    global matlab_function_dir
    global matlab_cmd
    global texture
    
    #Set command to start matlab script "textureRecognition.m"
    cmd_texture = matlab_cmd + " -nodesktop -nosplash -wait -r \"addpath(\'" + matlab_function_dir + "\'); textureRecognition(\'" + filename + "\', 0); quit\""
    subprocess.call(cmd_texture,shell=True)

    f5 = open(cur_dir + "\\texture.txt", "r")
    text = f5.read()
    bot.sendMessage(chat_id, text)
    Last_message_send = "Check texture"
    f5.close()

    f5b = open(cur_dir + "\\textureVal.txt", "r")
    texture = f5b.read()
    f5b.close()

def fileparts(fn):
    (dirName, fileName) = os.path.split(fn)
    (fileBaseName, fileExtension) = os.path.splitext(fileName)
    return dirName, fileBaseName, fileExtension

def imageHandler(bot, message, chat_id, local_filename):
    global cur_dir
    global matlab_function_dir
    global Last_message_send
    global current_image_name
    global matlab_cmd

    print(local_filename)
    current_image_name = local_filename

    cur_dir = os.path.dirname(os.path.realpath(__file__))
    matlab_function_dir = cur_dir + "\MatLab_functions"

    # Set matlab command
    if 'Linux' in platform.system():
        matlab_cmd = '/usr/local/bin/matlab'
    else:
        matlab_cmd = '"C:\\Program Files\\MATLAB\\R2020b\\bin\\matlab.exe"'

    #Send message to user
    bot.sendMessage(chat_id, "Hi, please wait until we tell you if the image is processable.")
    Last_message_send = "Hi, please wait until we tell you if the image is processable."

    #Set command to start matlab script "isBlurry.m"
    cmd_blur = matlab_cmd + " -nodesktop -nosplash -wait -r \"addpath(\'" + matlab_function_dir + "\'); isBlurry(\'" + local_filename + "\', 15, 0); quit\""
    #Launch command
    subprocess.call(cmd_blur,shell=True)

    #Set command to start matlab script "isBright.m"
    cmd_bright = matlab_cmd + " -nodesktop -nosplash -wait -r \"addpath(\'" + matlab_function_dir + "\'); isBright(\'" + local_filename + "\', 0); quit\""
    #Launch command
    subprocess.call(cmd_bright,shell=True)

    #Set command to start matlab script "isNoisy.m"
    cmd_noise = matlab_cmd + " -nodesktop -nosplash -wait -r \"addpath(\'" + matlab_function_dir + "\'); isNoisy(\'" + local_filename + "\', 0); quit\""
    #Launch command
    subprocess.call(cmd_noise,shell=True)

    f = open(cur_dir + "\\messages.txt", "r")
    message = f.read()
    f.close()

    f2 = open(cur_dir + "\\booleanAccepted.txt", "r")
    boolean = f2.read()
    f2.close()

    accepted = False
    if("1" not in boolean):
        accepted = True

    #send the response
    bot.sendMessage(chat_id, message)
    Last_message_send = message

    if(accepted):
        bot.sendMessage(chat_id, "Your image is going to be classified.")
        Last_message_send = "Your image is going to be classified."
        classifyClothes(bot, message, chat_id, local_filename)

    else:
        bot.sendMessage(chat_id, "Your image can not be processed. Do you want me to try to correct it ?")
        Last_message_send = "Your image can not be processed. Do you want me to try to correct it ?"

def textHandler(bot, message, chat_id, text):
    global Last_message_send
    global current_image_name
    global color
    global texture
    
    YES = ["yes", "Yes", "y", "Y"]
    print(text)
    if text == "help" or text == "Help":
        bot.sendMessage(chat_id, "Send me an image, and follow my instructions!\n"+
                        "To answer yes to a question, you can say  'Yes', 'yes', 'Y', or 'y'.\nTo answer no, you can send 'No', 'no', 'N', 'n', or anything else.")
    if Last_message_send == "":
        bot.sendMessage(chat_id, "Hi, please send me an image!")
    elif Last_message_send == "So please, try a new image!" or Last_message_send == "Please, try a new image!":
        bot.sendMessage(chat_id, "Please, try a new image!")
        Last_message_send = "Please, try a new image!"
    elif Last_message_send == "Your image can not be processed. Do you want me to try to correct it ?":
        if text in YES:
            bot.sendMessage(chat_id, "Ok, please wait until I've finish to correct your image.")
            Last_message_send = "Ok, please wait until I've finish to correct your image."
            cmd_correction = matlab_cmd + " -nodesktop -nosplash -wait -r \"addpath(\'" + matlab_function_dir + "\'); correction(\'" + current_image_name + "\'); quit\""
            sub = subprocess.call(cmd_correction, shell=True)
            if path.exists("Corrected.jpg") :
               bot.sendImage(chat_id, "Corrected.jpg", "This is your image corrected. Do you agree with this correction ?")
               Last_message_send = "This is your image corrected. Do you agree with this correction ?"
            else:
                bot.sendMessage(chat_id, "I'm really sorry, I cannot correct this image. Please, try a new one!")
                Last_message_send = "So please, try a new image!"
                os.remove(current_image_name)
                os.remove("booleanAccepted.txt")
                os.remove("messages.txt")
        else:
            bot.sendMessage(chat_id, "So please, try a new image!")
            Last_message_send = "So please, try a new image!"
            os.remove(current_image_name)
            os.remove("booleanAccepted.txt")
            os.remove("messages.txt")
    elif Last_message_send == "This is your image corrected. Do you agree with this correction ?":
        if text in YES:
            bot.sendMessage(chat_id, "The image is going to be classified.")
            Last_message_send = "The image is going to be classified."
            os.remove(current_image_name)
            current_image_name = "Corrected.jpg"
            classifyClothes(bot, message, chat_id, "Corrected.jpg")
        else:
            bot.sendMessage(chat_id, "So please, try a new image!")
            Last_message_send = "So please, try a new image!"
            os.remove(current_image_name)
            os.remove("booleanAccepted.txt")
            os.remove("messages.txt")
            os.remove("Corrected.jpg")
    elif Last_message_send == "Check clothes":
        if text in YES:
            detectColor(bot, message, chat_id, current_image_name)
        else:
            bot.sendMessage(chat_id, "I'm sorry about this error... Please, try with another image")
            Last_message_send = "Please, try a new image!"
            os.remove(current_image_name)
            os.remove("booleanAccepted.txt")
            os.remove("messages.txt")
            os.remove("label.txt")
            os.remove("labelNum.txt")
    elif Last_message_send == "Check color":
        if text in YES:
            detectTexture(bot, message, chat_id, current_image_name)
        else:
            bot.sendMessage(chat_id, "I'm sorry about this error... Can you please tell me what is the right color?\n"+
                            "Type 1 for black, 2 for blue, 3 for brown, 4 for green, 5 for grey, 6 for orange, 7 for pink, 8 for purple,"+
                            "9 for red, 10 for white or 11 for yellow.")
            Last_message_send = "Color?"
    elif Last_message_send == "Color?":
        if text == "1":
            color = 1
            detectTexture(bot, message, chat_id, current_image_name)
        elif text == "2":
            color = 2
            detectTexture(bot, message, chat_id, current_image_name)
        elif text == "3":
            color = 3
            detectTexture(bot, message, chat_id, current_image_name)
        elif text == "4":
            color = 4
            detectTexture(bot, message, chat_id, current_image_name)
        elif text == "5":
            color = 5
            detectTexture(bot, message, chat_id, current_image_name)
        elif text == "6":
            color = 6
            detectTexture(bot, message, chat_id, current_image_name)
        elif text == "7":
            color = 7
            detectTexture(bot, message, chat_id, current_image_name)
        elif text == "8":
            color = 8
            detectTexture(bot, message, chat_id, current_image_name)
        elif text == "9":
            color = 9
            detectTexture(bot, message, chat_id, current_image_name)
        elif text == "10":
            color = 10
            detectTexture(bot, message, chat_id, current_image_name)
        elif text == "11":
            color = 11
            detectTexture(bot, message, chat_id, current_image_name)
        else:
            bot.sendMessage(chat_id, "I'm sorry, but I cannot understand your response. Please, retry!")
            Last_message_send = "Color?"
    elif Last_message_send == "Check texture":
        if text in YES:
            bot.sendMessage(chat_id, "Perfect! Just one last question and I'll suggest an outfit!\n"+
                            "Do you want an outfit with the same color (type 1), the same texture (type 2) or both (type 3)?")
            Last_message_send = "kind of outfit?"
        else:
            bot.sendMessage(chat_id, "I'm sorry about this error... Can you please tell me what is the right texture?\n"+
                            "Type 1 for acrylic, 2 for corduroy, 3 for cotton, 4 for denim, 5 for leather, 6 for nylon, 7 for polyester, 8 for satin,"+
                            "or 9 for viscose.")
            Last_message_send = "Texture?"
    elif Last_message_send == "Texture?":
        if text == "1":
            texture = "Acrylic"
            bot.sendMessage(chat_id, "Perfect! Just one last question and I'll suggest an outfit!\n"+
                            "Do you want an outfit with the same color (type 1), the same texture (type 2) or both (type 3)?")
            Last_message_send = "kind of outfit?"
        elif text == "2":
            texture = "Corduroy"
            bot.sendMessage(chat_id, "Perfect! Just one last question and I'll suggest an outfit!\n"+
                            "Do you want an outfit with the same color (type 1), the same texture (type 2) or both (type 3)?")
            Last_message_send = "kind of outfit?"
        elif text == "3":
            texture = "Cotton"
            bot.sendMessage(chat_id, "Perfect! Just one last question and I'll suggest an outfit!\n"+
                            "Do you want an outfit with the same color (type 1), the same texture (type 2) or both (type 3)?")
            Last_message_send = "kind of outfit?"
        elif text == "4":
            texture = "Denim"
            bot.sendMessage(chat_id, "Perfect! Just one last question and I'll suggest an outfit!\n"+
                            "Do you want an outfit with the same color (type 1), the same texture (type 2) or both (type 3)?")
            Last_message_send = "kind of outfit?"
        elif text == "5":
            texture = "Leather"
            bot.sendMessage(chat_id, "Perfect! Just one last question and I'll suggest an outfit!\n"+
                            "Do you want an outfit with the same color (type 1), the same texture (type 2) or both (type 3)?")
            Last_message_send = "kind of outfit?"
        elif text == "6":
            texture = "Nylon"
            bot.sendMessage(chat_id, "Perfect! Just one last question and I'll suggest an outfit!\n"+
                            "Do you want an outfit with the same color (type 1), the same texture (type 2) or both (type 3)?")
            Last_message_send = "kind of outfit?"
        elif text == "7":
            texture = "Polyester"
            bot.sendMessage(chat_id, "Perfect! Just one last question and I'll suggest an outfit!\n"+
                            "Do you want an outfit with the same color (type 1), the same texture (type 2) or both (type 3)?")
            Last_message_send = "kind of outfit?"
        elif text == "8":
            texture = "Satin"
            bot.sendMessage(chat_id, "Perfect! Just one last question and I'll suggest an outfit!\n"+
                            "Do you want an outfit with the same color (type 1), the same texture (type 2) or both (type 3)?")
            Last_message_send = "kind of outfit?"
        elif text == "9":
            texture = "Viscose"
            bot.sendMessage(chat_id, "Perfect! Just one last question and I'll suggest an outfit!\n"+
                            "Do you want an outfit with the same color (type 1), the same texture (type 2) or both (type 3)?")
            Last_message_send = "kind of outfit?"
        else:
            bot.sendMessage(chat_id, "I'm sorry, but I cannot understand your response. Please, retry!")
            Last_message_send = "Texture?"
    elif Last_message_send == "kind of outfit?":
        if text == "1":
            outfitSameColor(bot, chat_id)
            os.remove(current_image_name)
            os.remove("booleanAccepted.txt")
            os.remove("messages.txt")
            os.remove("label.txt")
            os.remove("labelNum.txt")
            os.remove("color.txt")
            os.remove("colorNum.txt")
            os.remove("texture.txt")
            os.remove("textureVal.txt")
        elif text == "2":
            outfitSameTexture(bot, chat_id)
            os.remove(current_image_name)
            os.remove("booleanAccepted.txt")
            os.remove("messages.txt")
            os.remove("label.txt")
            os.remove("labelNum.txt")
            os.remove("color.txt")
            os.remove("colorNum.txt")
            os.remove("texture.txt")
            os.remove("textureVal.txt")
        elif text == "3":
            outfitBoth(bot, chat_id)
            os.remove(current_image_name)
            os.remove("booleanAccepted.txt")
            os.remove("messages.txt")
            os.remove("label.txt")
            os.remove("labelNum.txt")
            os.remove("color.txt")
            os.remove("colorNum.txt")
            os.remove("texture.txt")
            os.remove("textureVal.txt")
        else:
            bot.sendMessage(chat_id, "I'm sorry, but I cannot understand your response. Please, retry!")
            Last_message_send = "kind of outfit?"
    else:
        bot.sendMessage(chat_id, "Please wait until your image finish to be processed.")
        Last_message_send = "Please wait until your image finish to be processed."

if __name__ == "__main__":
    global Last_message_send
    Last_message_send = ""
    bot_id = '1461723734:AAFTgtj7DCKmhBOi6svlNTtuqmYBSnHp5I4'
    updater = Updater(bot_id)
    updater.setPhotoHandler(imageHandler)
    updater.setTextHandler(textHandler)
    updater.start()
