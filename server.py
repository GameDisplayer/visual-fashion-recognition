import os, sys, platform, subprocess
import os.path
from os import path

os.chdir(os.getcwd())
bot_dir = 'python_bot-master'
sys.path.append(bot_dir)

from Updater import Updater

def classifyImage(bot, message, chat_id, filename):
    global Last_message_send
    global cur_dir
    global matlab_function_dir
    global matlab_cmd

    #Set command to start matlab script "classification.m"
    cmd_classification = matlab_cmd + " -nodesktop -nosplash -wait -r \"addpath(\'" + matlab_function_dir + "\'); classification(\'" + filename + "\'); quit\""
    #Launch command
    subprocess.call(cmd_classification,shell=True)

    f3 = open(cur_dir + "\\label.txt", "r")
    label = f3.read()
    bot.sendMessage(chat_id, label)
    Last_message_send = label

    #Set command to start matlab script "getColor.m"
    cmd_classification = matlab_cmd + " -nodesktop -nosplash -wait -r \"addpath(\'" + matlab_function_dir + "\'); getColor(\'" + filename + "\'); quit\""
    #Launch command
    subprocess.call(cmd_classification,shell=True)

    f4 = open(cur_dir + "\\color.txt", "r")
    color = f4.read()
    bot.sendMessage(chat_id, color)
    Last_message_send = color

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

    f2 = open(cur_dir + "\\booleanAccepted.txt", "r")
    boolean = f2.read()

    accepted = False
    if("1" not in boolean):
        accepted = True

    #send the response
    bot.sendMessage(chat_id, message)
    Last_message_send = message

    if(accepted):
        bot.sendMessage(chat_id, "Your image is going to be classified.")
        Last_message_send = "Your image is going to be classified."
        classifyImage(bot, message, chat_id, local_filename)

        #A LA FIN DU TRAITEMENT D'IMAGE! SURTOUT PAS AVANT!
        os.remove(local_filename)

    else:
        bot.sendMessage(chat_id, "Your image can not be processed. Do you want me to try to correct it ?")
        Last_message_send = "Your image can not be processed. Do you want me to try to correct it ?"

def textHandler(bot, message, chat_id, text):
    global Last_message_send
    print(text)
    if text == "help" or text == "Help":
        bot.sendMessage(chat_id, "Send me an image, and follow my instruction!\n"+
                        "To answer yes to a question, you can say  'Yes', 'yes', 'Y', or 'y'.\nTo answer no, you can send 'No', 'no', 'N', or 'n'.")
    if Last_message_send == "":
        bot.sendMessage(chat_id, "Hi, please send me an image!")
    elif Last_message_send == "So please, try a new image!" or Last_message_send == "Please, try a new image!":
        bot.sendMessage(chat_id, "Please, try a new image!")
        Last_message_send = "Please, try a new image!"
    elif Last_message_send == "Your image can not be processed. Do you want me to try to correct it ?":
        if text == "yes" or text == "Yes" or text == "y" or text == "Y":
            bot.sendMessage(chat_id, "Ok, please wait until I've finish to correct your image.")
            Last_message_send = "Ok, please wait until I've finish to correct your image."
            cmd_correction = matlab_cmd + " -nodesktop -nosplash -wait -r \"addpath(\'" + matlab_function_dir + "\'); correction(\'" + current_image_name + "\'); quit\""
            sub = subprocess.call(cmd_correction, shell=True)
            if path.exists("Corrected.jpg") :
               bot.sendImage(chat_id, "Corrected.jpg", "This is your image corrected. Do you agree with this correction ?")
               Last_message_send = "This is your image corrected. Do you agree with this correction ?"
        else:
            bot.sendMessage(chat_id, "So please, try a new image!")
            Last_message_send = "So please, try a new image!"
            os.remove(current_image_name)
    elif Last_message_send == "This is your image corrected. Do you agree with this correction ?":
        if text == "yes" or text == "Yes" or text == "y" or text == "Y":
            bot.sendMessage(chat_id, "The image is going to be classified.")
            Last_message_send = "The image is going to be classified."
            classifyImage(bot, message, chat_id, "Corrected.jpg")
            os.remove(current_image_name)
            os.remove("Corrected.jpg")
        else:
            bot.sendMessage(chat_id, "So please, try a new image!")
            Last_message_send = "So please, try a new image!"
            os.remove(current_image_name)
            os.remove("Corrected.jpg")
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
