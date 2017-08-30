from sys import argv

script, first, second = argv

print("Script name is: ", script)
print("The first variable is: ", first)
print("The second variable uis: ", second)
a = input("Are u satisfied ? Type Y or N: ")
if a == "Y" or a == "y":
	print("Glad to hear you really like it!")
else:
	print("So u'r not satisfied :( ")	
b = input("Please evaluate programm quiality with numbers from 1 to 5: ")
print("Thanks for evaluation, your value is:", b)
