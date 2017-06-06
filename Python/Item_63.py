import shutil
import os

source = '..\..\..\Desktop\Folder A'
dest = '..\..\..\Desktop\Folder B'

files = os.listdir(source)

for f in files:
    shutil.move("{}\{}".format(source,f), dest)
    print("{}\{}".format(dest,f))
        


