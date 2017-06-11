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
import sqlite3

import file_transfer_gui
import file_transfer

#Defining global variables for time and directories.
working = ''
transfer = ''
testTime = datetime(2017,5,10,18,30,50,200) #Random datetime used for testing purposes and to initalize the database.
now = datetime.now()

#Function to center the GUI window.
def center_window(self, w, h): 
    screen_width = self.master.winfo_screenwidth()
    screen_height = self.master.winfo_screenheight()
    x = int((screen_width/2) - (w/2))
    y = int((screen_height/2) - (h/2))
    centerGeo = self.master.geometry('{}x{}+{}+{}'.format(w, h, x, y))
    return centerGeo

#Function for closing the program. 
def ask_quit(self):
    if messagebox.askokcancel("Exit program", "Okay to exit application?"):
        self.master.destroy()
        os._exit(0)

#Function to get user's selected working files folder. 
def getWorking(self):
    global working
    working = askdirectory()
    self.txt_wfiles.delete('0','end')
    self.txt_wfiles.insert(END,working)
    return working

#Function to get user's selected destination folder. 
def getDest(self):
    global transfer
    transfer = askdirectory()
    self.txt_tfiles.delete('0','end')
    self.txt_tfiles.insert(END,transfer)
    return transfer

#Function to check a user choosen folder for new or modified files and
#copy them to a user choosen destination folder. (Done)
def copyFiles(self):
    currTime = datetime.now()
    timeAdj = timedelta(hours=24)
#This is to first check when the last run was made and if less than 24hrs ago ask user if they want to continue.
    conn = sqlite3.connect('db_lastRun.db')
    with conn:
        cur = conn.cursor()
        cur.execute("""SELECT timeStamp FROM tbl_lastRun""")
        timeStamp = cur.fetchone()[0]
    conn.close()
    formatTimeStamp = datetime.strptime(timeStamp,'%Y-%m-%d %H:%M:%S.%f')
    if currTime < formatTimeStamp + timeAdj:
        if messagebox.askokcancel("Copy Run", "Last copy run was less than 24hrs do you wish to proceed?") != True:
            return
#Main meat of the function to check for new or recently modified files and copy what needs to be copied to destination folder.
    try:
        files = os.listdir(working)
        destfiles = os.listdir(transfer)
        self.display.insert(END,"\nThe following files have been copied over:")
    except FileNotFoundError:
        self.display.insert(END,"\nPlease use the search boxes to select both a working files folder and a destination folder.")
        return
    for f in files:
        if datetime.fromtimestamp(os.path.getmtime("{}\{}".format(working,f))) > currTime - timeAdj:
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
#To update the timestamp in the SQL database.
    conn = sqlite3.connect('db_lastRun.db')
    with conn:
        currTime = datetime.now()
        cur = conn.cursor()
        cur.execute("""UPDATE tbl_lastRun SET timeStamp = '{}' WHERE ID = 1""".format(currTime))
        conn.commit()
    conn.close()
    
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

#Function to create database and inital table if needed.
def create_db(self):
    conn = sqlite3.connect('db_lastRun.db')
    with conn:
        cur = conn.cursor()
        cur.execute("CREATE TABLE if not exists tbl_lastRun( \
            ID INTEGER PRIMARY KEY AUTOINCREMENT, \
            Year INTEGER, \
            Month INTEGER,\
            Day INTEGER, \
            Hour INTEGER, \
            Minute INTEGER, \
            timeStamp INTEGER);")
        conn.commit()
    conn.close()
    initalize_db(self)

#Used to count the number of records in the database to check if the database needs to be initalized.
def count_records(cur):
    count = ""
    cur.execute("""SELECT COUNT(*) FROM tbl_lastRun""")
    count = cur.fetchone()[0]
    return cur,count

#Function to give the database an inital time stamp value.
def initalize_db(self):
    conn = sqlite3.connect('db_lastRun.db')
    with conn:
        cur = conn.cursor()
        cur,count = count_records(cur)
        if count < 1:
            cur.execute("""INSERT INTO tbl_lastRun (timeStamp) VALUES (?)""", [testTime])
            self.display.insert(END,"Last copy run was: This is the first time running")
            conn.commit()
        else:
            printLast(self)
    conn.close()

#Function to print last time the script was ran on open. 
def printLast(self):
    conn = sqlite3.connect('db_lastRun.db')
    with conn:
        cur = conn.cursor()
        cur.execute("""SELECT timeStamp FROM tbl_lastRun""")
        lastRun = cur.fetchone()[0]
        formatLastRun = datetime.strptime(lastRun,'%Y-%m-%d %H:%M:%S.%f')
        formatTime = datetime.strftime(formatLastRun,"%I:%M %p")
        self.display.insert(END,"Last copy run was: {:%m-%d-%Y} at ".format(formatLastRun) + formatTime)    
    conn.close()

