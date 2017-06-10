#Python 3.6.1
#Author: Bill Bonney
#The Tech Academy Python Item 65
"""The purpose of this program is to create a script that will check for new or modified files in one folder,
and copy them to another folder with a user interface.  This file is the main page of the script to keep code separated and cleaner."""



from tkinter import *

import file_transfer_func
import file_transfer_gui

class ParentWindow(Frame):
    def __init__(self, master, *args, **kwargs):
        Frame.__init__(self,master, *args, **kwargs)

        self.master = master
        self.master.minsize(650,275)
        self.master.maxsize(650,275)
        file_transfer_func.center_window(self,650,275)
        self.master.title("Files to be Transferred Script")
        self.master.configure(bg="dodger blue")
        self.master.protocol("WM_DELETE_WINDOW", lambda: file_transfer_func.ask_quit(self))
        arg = self.master
        
        file_transfer_gui.load_gui(self)

if __name__ == "__main__":
    root = Tk()
    App = ParentWindow(root)
    root.mainloop()
