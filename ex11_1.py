#lets try some choise menu
from datetime import datetime

print 30 * '-'
print " MAIN MENU"
print 30 * '-'
print "1. Show me current date"
print "2. Start backup"
print "3. Exit programm"

choise = int(raw_input("Please choose [1-3] options: "))
#choise = int(choise)

if choise == 1:
	print datetime.now()
elif choise == 2:
	print "Starting backup"
elif choise ==3:
	print "Exiting programm"
else:
	print "Incorrect value entered, try again"		

