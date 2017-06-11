- This program was created for the Tech Academy Python course item 66.
- The purpose is to create a program for copying new or recently modified files in a folder, with a GUI, and a database for storing a timestamp of the last time the program was ran. 
- Use the "file_transfer.pyw" file to run the program.
- Currently the main file is saved as a .pyw so that it can be run on Windows without the command window.
It's my understanding this file type can't be run on other operating systems. If needed just rename the file to "file_transfer.py".

- Please note on first run the database is initalized with a random date for the timestamp.  When the program is executed the timestamp gets updated with the current time.
Each subsequent time the program is started the last run date will be displayed, and if the stored timestamp is less than 24hrs the user will be prompted to confirm they want to run it now.
