#lets try some choise menu
from datetime import datetime, date

print 30 * '-'
print " MAIN MENU"
print 30 * '-'
print "1. Show me current date"
print "2. Show me current year"
print "3. Start backup"
print "4. Exit programm"

choise = int(raw_input("Please choose [1-3] options: "))
#choise = int(choise)

if choise == 1:
	print datetime.now()
elif choise == 2:
#Two ways to show current year
#1st
	print date.today().year
#2nd
#	print datetime.now().year
#
elif choise == 3:
	print "Starting backup"
elif choise == 4:
	print "Exiting programm"
else:
	print "Incorrect value entered, try again"		

