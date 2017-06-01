# Python: 3.6.1
#
#Author: Bill Bonney
#
#Purpose:  The Tech Academy - Python item 36
"""    The purpose of this project was to write a program that meets all of the following criteria.
1. Assign an integer to a variable

2. Assign a string to a variable

3. Assign a float to a variable

4. Use the print function and .format() notation to print out the variable you assigned  

5. Use each of these operators +, - , * , / , +=, ­= , %

6. Use of logical operators: and, or, not

7. Use of conditional statements: if, elif, else

8. Use of a while loop

9. Use of a for loop

10. Create a list and iterate through that list using a for loop to print each item out on a new line

11. Create a tuple and iterate through it using a for loop to print each item out on a new line

12. Define a function that returns a string variable

13. Call the function you defined above and print the result to the shell

This program is created to take in information and return some random predictions
about the user."""



def start(name="",age=0,gender="",income=0.0):
    print("Howdy partner, welcome to Crazy Bob's Texas Psychic Emporium! First my lawyers insist I go over the following with you before we begin.")
    getDisclaimer()
    print("\nNow let me start by getting to know you a little bit then I will give you your predictions.")
    name,age,gender,income = getInfo(name,age,gender,income)
    makePredictions(age,gender,income)
    getSponsors(age,income)
    
#This function satisfies the following criteria. Use of if, elif, else. 8. Use of a while loop,9. Use of a for loop, & 11. Create a tuple and iterate through it to print each item on a new line. 
def getDisclaimer(answer=""):
    disclaimerTup = ("1. This is strictly for entertainment purposes","2. While we are called Crazy Bob's Texas Psychic Emporium no one here is named Bob, or from Texas","3. My psychic's licenses is currently being challenged by the state, and oddly enough PETA","4. Neither I, nor any of my staff claim to be truly psychic","5. And most importantly please remember this is all in good fun")
    for disclaimer in disclaimerTup:
        print("\n" + disclaimer + ".")
    answer = input("\nDo you understand, and accept these disclaimers?(yes,no)").lower()
    stop = True
    while stop:
        if answer == "yes":
            stop = False
        elif answer == "no":
            print("\nOk well either reread and accept, or don't let the door hit you on the way out...")
            for disclaimer in disclaimerTup:
                print("\n" + disclaimer + ".")
            answer = input("\nDo you understand, and accept these disclaimers now?(yes,no)").lower()
        else:
            answer = input("\nPlease just enter yes or no.")

#This function uses the or operator and satisfies the following criteria. 1. Assign an integer to a variable, 2. Assign a string to a variable, 3. Assign a float to a variable, 4. Use the print function and.format, 12. Define a function that returns a string variable, 13. Print the results of the function to the shell. 
def getInfo(name,age,gender,income):
    name = input("\nWhat is your name?").capitalize()
    print("\nThanks {}! Nice to meet you.  I'm not getting any strong feelings yet, let me get a little more information about you.  Hopefully that will open some channels.".format(name))
    stop = True
    gender = input("\nAre you male(m) or female(f)? You never know with names these days, and I don't want to assume.").lower()
    while stop:
        if gender == "m" or gender == "f":
            stop = False
        else:
            gender = input("\nPlease just enter (m) or (f).").lower()
    while age == 0:
        try:
            age = int(input("\nHow old are you?"))
        except ValueError:
            print("\nEnter just the number please")       
    print("\nI'm starting to see something, but it's weak. Just one more question should do it.")
    while income == 0.0:
        try:
            income = float(input("\nRoughly what is your yearly income. Don't worry it won't affect how much I charge you..."))
        except ValueError:
            print("\nSorry I didn't get that please enter a number in decimal form.")
    print("\nThat's it now I see it")
    return name,age,gender,income

def makePredictions(age,gender,income,intro="",prediction1="",prediction2="",prediction3=""):
    intro = getIntro(age,gender,income,intro)
    prediction1 = getPredict1(age,gender,income,prediction1)
    prediction2 = getPredict2(age,gender,income,prediction2)
    prediction3 = getPredict3(age,gender,income,prediction3)
    print("\n\n{} \n\n{} \n\n{} \n\n{}".format(intro,prediction1,prediction2,prediction3))

#This function uses the and operator.
def getIntro(age,gender,income,intro=""):
    if gender == "m" and age >= 25:
        intro = "Well partner things aren't great, but they could be worse."
    elif gender == "m" and age <25:
        intro = "Sorry buddy, I have some bad news."
    elif gender == "f" and age >= 25:
        intro = "Well mam you've seen better days, but your future doesn't seem too bad."
    else:
        intro = "I've got some great news little lady."
    return intro

#This function uses -= operator.
def getPredict1(age,gender,income,prediction1=""):
    if age >= 25:
        age -= 12
        prediction1 = "When you were " + str(age) + " years old, you made a terrible choice that has haunted you ever since."
    elif age < 25 and gender == "m":
        prediction1 = "When you were younger you did something very stupid, and your life won't ever be the same."
    else:
        prediction1 = "When you were younger you were younger you made all the right choices.  Too bad it didn't help..."
    return prediction1

#This function uses the += operator.
def getPredict2(age,gender,income,prediction2=""):
    if age > 25:
        age += 6
        prediction2 = "Around your " + str(age) + "th birthday you will be approached by a mysterious old women who will give you great advice."
    elif age <= 25 and gender == "m":
        age += 7
        prediction2 = "By the time you turn " + str(age) + " you will be living out of a van.  Most likely down by the river.  On the plus side it's a van so you can easily change your view."
    else:
        prediction2 = "In about 10 years you will have the roughest year of your life.  On the upside you will learn a lot, and since it's the worst year of your life it can only get better from there."
    return prediction2

#This function uses the following operators +,-,*,/,%
def getPredict3(age,gender,income,prediction3="",incMod=0.0,savings=0.0,futureInc=0.0):
    if age >= 25 or income >= 60000:
        incMod = income % 3
        savings = round(income * 5 + (incMod * 200), 2)
        futureInc = round(income * 2.2, 2)
        prediction3 = "At least your financial situation doesn't look too bad.  In 15 years your future income will be " + str(futureInc) + ", and your savings will be around " + str(savings) + "."
    elif age < 25 and gender == "m":
        incMod = income % 3
        savings = round(income * 3 - 300000, 2)
        futureInc = round(income/3 + (incMod * 100), 2)
        prediction3 = "Well sorry fella things don't look good for your financial future.  In about 15 years your future income will be " + str(futureInc) + ", and your savings will be around " + str(savings) + ". Don't worry about paying me.  It's on the house."
    else:
        incMod = income % 3
        savings = round(income * 10, 2) 
        futureInc = round(income * 4, 2)
        prediction3 = "Your going to kill it at work over the next 10 years, and 15 years from now your financial future looks great. Your future income will be around " + str(futureInc) + ", and your savings will be around " + str(savings) + ". So now let's discuss my payment."
    return prediction3

#This function uses the not operator and satisfies criteria 10. Create a list and iterate through it to print each item to a new line.
def getSponsors(age,income):
    print("\n\nThanks for coming in. You should also check out some of our sponsors!")
    highIncOld = ["-Dr. Spaceman. If you need drugs we got'em","-cPant. Caffeine infused underwear that will destroy fat and cellulite...probably","-Hector's Premium Blueberry Tequila. For those of us who need a little help vomitting"]
    highIncYoung = ["-Dr. Spaceman. If you need drugs we got'em","-Magic Pill. A revolutionary weight loss pill made from newly discovered plants in the Amazon. Just believe you muggle","-Lacey's House of Pasta. For those of us who want to stick it to our Paleo friends"]
    lowInc = ["-Leroy's spiced box wine. For those of us that love grape juice, but wish it tasted more like a bathtub","-Jim's auto repair. We usually get the job done","-Nonna RoRo's Pizzaria. It's the Taco Bell of Italian food. It resembles Italian food, but come on who are we kidding"]
    if not income > 40000:
        for sponsor in lowInc:
            print("\n" + sponsor + ".")
    elif age > 30:
        for sponsor in highIncOld:
            print("\n" + sponsor + ".")
    else:
        for sponsor in highIncYoung:
            print("\n" + sponsor + ".")
    
if __name__ == "__main__":
    start()
