import datetime

class EST(datetime.tzinfo):
    def utcoffset(self, dt):
      return datetime.timedelta(hours=-4)

    def dst(self, dt):
        return datetime.timedelta(0)
    
class UTC1(datetime.tzinfo):
    def utcoffset(self, dt):
      return datetime.timedelta(hours=+1)

    def dst(self, dt):
        return datetime.timedelta(0)

portland = datetime.datetime.now().time()
newYork = datetime.datetime.now(EST()).time()
london = datetime.datetime.now(UTC1()).time()
openHours = datetime.time(9)
closeHours = datetime.time(18)

def checkLondon(london,openHours,closeHours):
    if london > openHours and london < closeHours:
        print("\nThe London office is currently open")
    else:
        print("\nThe London office is currently closed")

def checkNewYork(newYork,openHours,closeHours):
    if newYork > openHours and newYork < closeHours:
        print("\nThe New York office is currently open")
    else:
        print("\nThe New York office is currently closed")
        
checkLondon(london,openHours,closeHours)
checkNewYork(newYork,openHours,closeHours)

