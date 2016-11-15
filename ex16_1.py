from sys import argv

script, filename = argv

print "We're going to erase %r." % filename
print "If u don't wanna do that press CTRL-C"
print "If u DO wanna do that, press ENTER"

raw_input('?')

print "Opening the file..."
target = open(filename, 'w')

print "Truncating the file, goodbye"
target.truncate()

print "Now I'm going to ask you to provide 3 lines."

line1 = raw_input("Line 1: ")
line2 = raw_input("Line 2: ")
line3 = raw_input("Line 3: ")
line = line1, '\n', line2, '\n', line3, '\n'
#print line
print "Now I'm goint write above to the file."

target.writelines(line)

print "And finally lets close that file."

target.close()