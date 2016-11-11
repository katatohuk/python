from sys import argv

script, filename = argv
txt = open(filename)

print "Here is ur file %r: " % filename
print txt.read()

#We can ask to in 2 different ways.
#1
print "Print the file name again:"
file_again = raw_input("> ")
#2
#file_again = raw_input("Print the file name again: ")

txt_again = open(file_again)
print txt_again.read()