list1 = [67,45,2,13,1,998]
list2 = [89,23,33,45,10,12,45,45,45]

def sortFunction(oldList,newList=[]):
    newList = []
    while oldList:
        start = oldList[0]
        for x in oldList:
            if x < start:
                start = x
        newList.append(start)
        oldList.remove(start)

    print(newList)
        
            
sortFunction(list1)
print("\n")
sortFunction(list2)
