#Python 3.6.1
#Author: Bill Bonney
#The Tech Academy Python Item 64
"""The purpose of this program is to create a script that will check for new or modified files in one folder,
and copy them to another folder with a user interface.  This file contains the main functions used in the program."""

import shutil
import os
from datetime import *
from tkinter import *
from tkinter import messagebox
from tkinter.filedialog import askdirectory
import file_transfer_gui
import file_transfer

#Defining global variables for time and directories.
working = ''
transfer = ''
now = datetime.now()
timeAdj = timedelta(hours=24)

#Function to center the GUI window. (Done)
def center_window(self, w, h): 
    screen_width = self.master.winfo_screenwidth()
    screen_height = self.master.winfo_screenheight()
    x = int((screen_width/2) - (w/2))
    y = int((screen_height/2) - (h/2))
    centerGeo = self.master.geometry('{}x{}+{}+{}'.format(w, h, x, y))
    return centerGeo

#Function for closing the program. (Done)
def ask_quit(self):
    if messagebox.askokcancel("Exit program", "Okay to exit application?"):
        self.master.destroy()
        os._exit(0)

#Function to get user's selected working files folder. (Done)
def getWorking(self):
    global working
    working = askdirectory()
    self.txt_wfiles.delete('0','end')
    self.txt_wfiles.insert(END,working)
    return working

#Function to get user's selected destination folder. (Done)
def getDest(self):
    global transfer
    transfer = askdirectory()
    self.txt_tfiles.delete('0','end')
    self.txt_tfiles.insert(END,transfer)
    return transfer

#Function to check a user choosen folder for new or modified files and
#copy them to a user choosen destination folder. (Done)
def copyFiles(self):
    try:
        files = os.listdir(working)
        destfiles = os.listdir(transfer)
        self.display.insert(END,"\nThe following files have been copied over:")
    except FileNotFoundError:
        self.display.insert(END,"\nPlease use the search boxes to select both a working files folder and a destination folder.")
        return
    for f in files:
        if datetime.fromtimestamp(os.path.getmtime("{}\{}".format(working,f))) > now - timeAdj:
            try:
                shutil.copyfile("{}\{}".format(working,f),("{}\{}".format(transfer,f)))
                self.display.insert(END,"\n" + f)
                
            except SameFileError:
                os.remove("{}\{}".format(transfer,f))
                shutil.copyfile("{}\{}".format(working,f),("{}\{}".format(transfer,f)))
                self.display.insert(END,"\n" + f)
                
        elif os.path.isfile("{}\{}".format(transfer,f)) != True:
            shutil.copyfile("{}\{}".format(working,f),("{}\{}".format(transfer,f)))
            self.display.insert(END,"\n" + f)

#Function to check if any files need to be transferred over.
def checkFiles(self):
    try:
        files = os.listdir(working)
        destfiles = os.listdir(transfer)
        self.display.insert(END,"\nThe following files are new or have been recently modified:")
    except FileNotFoundError:
        self.display.insert(END,"\nPlease use the search boxes to select both a working files folder and a destination folder.")
        return
    for f in files:
        if datetime.fromtimestamp(os.path.getmtime("{}\{}".format(working,f))) > now - timeAdj:
            self.display.insert(END,"\n" + f)      
        elif os.path.isfile("{}\{}".format(transfer,f)) != True:
            self.display.insert(END,"\n" + f)

