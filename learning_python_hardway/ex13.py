#usage: ex13.py 1 2 3
#output:
#Andrey@/git/python| python3 ex13.py 1 2 3
#The script is called:  ex13.py
#1st variable is:  1
#2nd variable is:  2
#3rd varialbe is:  3

from sys import argv
script, first, second, third = argv

print("The script is called: ", script)
print("1st variable is: ", first)
print("2nd variable is: ", second)
print("3rd varialbe is: ", third)