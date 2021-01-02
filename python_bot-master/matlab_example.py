from Updater import Updater
import os, sys, platform, subprocess

def fileparts(fn):
    (dirName, fileName) = os.path.split(fn)
    (fileBaseName, fileExtension) = os.path.splitext(fileName)
    return dirName, fileBaseName, fileExtension


def imageHandler(bot, message, chat_id, local_filename):
	print(local_filename)
	# send message to user
	bot.sendMessage(chat_id, "Hi, please wait until the image is processed")
	# set matlab command
	if 'Linux' in platform.system():
		matlab_cmd = '/usr/local/bin/matlab'
	else:
		matlab_cmd = '"C:\\Program Files\\MATLAB\\R2020b\\bin\\matlab.exe"'
	cur_dir = os.path.dirname(os.path.realpath(__file__))
	
	### EXAMPLE ###
	
	# set command to start matlab script "edges.m"
	#cmd = matlab_cmd + " -nodesktop -nosplash -nodisplay -wait -r \"addpath(\'" + cur_dir + "\'); edges(\'" + local_filename + "\'); quit\""
	# lunch command
	#subprocess.call(cmd,shell=True)
	# send back the manipulated image
	#dirName, fileBaseName, fileExtension = fileparts(local_filename)
	#new_fn = os.path.join(dirName, fileBaseName + '_ok' + fileExtension)
	#bot.sendImage(chat_id, new_fn, "")

	### TEST ###
	
	# set command to start matlab script "isBlurry.m"
	cmd_blur = matlab_cmd + " -nodesktop -nosplash -nodisplay -wait -r \"addpath(\'" + cur_dir + "\'); isBlurry(\'" + local_filename + "\', 21); quit\""
	#launch command
	subprocess.call(cmd_blur,shell=True)
	
	cmd_bright = matlab_cmd + " -nodesktop -nosplash -nodisplay -wait -r \"addpath(\'" + cur_dir + "\'); isBright(\'" + local_filename + "\'); quit\""
	subprocess.call(cmd_bright,shell=True)
	
	f = open(cur_dir + "\\messages.txt", "r")
	message = f.read() 
        #send the response
	bot.sendMessage(chat_id, message)
	


if __name__ == "__main__":
	bot_id = '1461723734:AAFTgtj7DCKmhBOi6svlNTtuqmYBSnHp5I4'
	updater = Updater(bot_id)
	updater.setPhotoHandler(imageHandler)
	updater.start()
