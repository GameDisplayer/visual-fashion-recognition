import os, sys, platform, subprocess

os.chdir(os.getcwd())
bot_dir = 'python_bot-master'
sys.path.append(bot_dir)

from Updater import Updater

def fileparts(fn):
    (dirName, fileName) = os.path.split(fn)
    (fileBaseName, fileExtension) = os.path.splitext(fileName)
    return dirName, fileBaseName, fileExtension

def imageHandler(bot, message, chat_id, local_filename):
    print(local_filename)
    #Send message to user
    bot.sendMessage(chat_id, "Hi, please wait until we tell you if the image is processable.")
    #Set matlab command
    if 'Linux' in platform.system():
        matlab_cmd = '/usr/local/bin/matlab'
    else:
        matlab_cmd = '"C:\\Program Files\\MATLAB\\R2020b\\bin\\matlab.exe"'
    cur_dir = os.path.dirname(os.path.realpath(__file__))
    matlab_function_dir = cur_dir + "\MatLab_functions"


    #Set command to start matlab script "isBlurry.m"
    cmd_blur = matlab_cmd + " -nodesktop -nosplash -wait -r \"addpath(\'" + matlab_function_dir + "\'); isBlurry(\'" + local_filename + "\', 15); quit\""
    #Launch command
    subprocess.call(cmd_blur,shell=True)

    #Set command to start matlab script "isBright.m"
    cmd_bright = matlab_cmd + " -nodesktop -nosplash -wait -r \"addpath(\'" + matlab_function_dir + "\'); isBright(\'" + local_filename + "\'); quit\""
    #Launch command
    subprocess.call(cmd_bright,shell=True)

    #Set command to start matlab script "isNoisy.m"
    cmd_noise = matlab_cmd + " -nodesktop -nosplash -wait -r \"addpath(\'" + matlab_function_dir + "\'); isNoisy(\'" + local_filename + "\'); quit\""
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

    if(accepted):
        bot.sendMessage(chat_id, "Your image can be processed.")
        
        #Set command to start matlab script "classification.m"
        cmd_classification = matlab_cmd + " -nodesktop -nosplash -wait -r \"addpath(\'" + matlab_function_dir + "\'); classification(\'" + local_filename + "\'); quit\""
        #Launch command
        subprocess.call(cmd_classification,shell=True)

        f3 = open(cur_dir + "\\label.txt", "r")
        label = f3.read()
        bot.sendMessage(chat_id, label)
    else:
        bot.sendMessage(chat_id, "Your image can not be processed. Send us a new one !")


if __name__ == "__main__":
    bot_id = '1461723734:AAFTgtj7DCKmhBOi6svlNTtuqmYBSnHp5I4'
    updater = Updater(bot_id)
    updater.setPhotoHandler(imageHandler)
    updater.start()
