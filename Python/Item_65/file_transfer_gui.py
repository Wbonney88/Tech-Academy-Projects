#Python 3.6.1
#Author: Bill Bonney
#This is the GUI code for The Tech Academy Python Item 65 drill

from tkinter import *
import file_transfer_func
import file_transfer

                         
def load_gui(self):
    self.lbl_wfiles = Label(self.master,text="Working Files", bg="dodger blue", fg="snow", font="-weight bold")
    self.lbl_wfiles.grid(row=0,column=0,columnspan=2,padx=(5,0),sticky=S+W)
    self.lbl_tfiles = Label(self.master,text="Destination", bg="dodger blue", fg="snow", font="-weight bold")
    self.lbl_tfiles.grid(row=2,column=0,columnspan=2,padx=(5,0),sticky=S+W)
    
    self.txt_wfiles = Entry(self.master,text="")
    self.txt_wfiles.grid(row=1,column=0,columnspan=2,padx=(5,0),sticky=E+N)
    self.txt_tfiles = Entry(self.master,text="")
    self.txt_tfiles.grid(row=3,column=0,columnspan=2,padx=(5,0),sticky=E+N)

#Defining and resizing the search button images.
    magImage = PhotoImage(file="..\..\..\..\Desktop\My_Project\Python\Item_65\\mag_glass.gif")
    buttonImage = magImage.subsample(13,13)
    Button.img = buttonImage
    
    self.wfilesearch = Button(self.master)
    self.wfilesearch.config(image = buttonImage,compound = 'center',command=lambda: file_transfer_func.getWorking(self))
    self.wfilesearch.grid(row=1,column=2,pady=(1,0),sticky=W+N)
    self.wfilesearch = Button(self.master)
    self.wfilesearch.config(image = buttonImage,compound = 'center',command=lambda: file_transfer_func.getDest(self))
    self.wfilesearch.grid(row=3,column=2,pady=(1,0),sticky=W+N)
    
    self.scrollbar1 = Scrollbar(self.master,orient=VERTICAL)
    self.display = Text(self.master, height=15, width=42,yscrollcommand=self.scrollbar1.set,wrap=WORD)
    self.scrollbar1.config(command=self.display.yview)
    self.scrollbar1.grid(row=0,column=5,rowspan=5,pady=(10,0),sticky=N+E+S)
    self.display.grid(row=0,column=3,rowspan=5,columnspan=2,padx=(5,0),pady=(10,0))

    self.btn_run = Button(self.master,width=12,height=2,text='Run',command=lambda: file_transfer_func.copyFiles(self))
    self.btn_run.grid(row=4,column=0,sticky=S)
    self.btn_checkfiles = Button(self.master,width=12,height=2,text='Check Files',command=lambda: file_transfer_func.checkFiles(self))
    self.btn_checkfiles.grid(row=4,column=2,padx=(0,10),sticky=S)
    
if __name__ == "__main__":
    pass

