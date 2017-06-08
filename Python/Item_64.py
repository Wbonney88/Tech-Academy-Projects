#Python 3.6.1
#Author: Bill Bonney
#The Tech Academy Python Item 64
"""The purpose of this program is to create a script that will check for new or modified files in one folder,
and copy them to another folder."""

import shutil
import os
from datetime import *

#Defining global variables for time and directories.
working = '..\..\..\Desktop\Working_Files'
transfer = '..\..\..\Desktop\To_Corporate'
now = datetime.now()
timeAdj = timedelta(hours=24)
files = os.listdir(working)

#Script to check folder "Working_Files" on the desktop for new or modified files and copy them to the folder "To_Corporate" also on the desktop.
for f in files:
    if datetime.fromtimestamp(os.path.getmtime("{}\{}".format(working,f))) > now - timeAdj:
        try:
            shutil.copyfile("{}\{}".format(working,f),("{}\{}".format(transfer,f)))
        except SameFileError:
            os.remove("{}\{}".format(transfer,f))
            shutil.copyfile("{}\{}".format(working,f),("{}\{}".format(transfer,f)))
    elif os.path.isfile("{}\{}".format(transfer,f)) != True:
        shutil.copyfile("{}\{}".format(working,f),("{}\{}".format(transfer,f)))
