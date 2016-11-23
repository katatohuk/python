from sys import argv
from os.path import exists

script, from_file, to_file = argv

print "Copyin from %s to %s file." % (from_file, to_file)

#in_file = open(from_file)
#indata = in_file.read()
indata = open(from_file).read()

#indata = in_file.read()

if len(indata) == 0:
	print "File %s is empy, please add some data"
else:	
	print "Ready, hit ENTER to continue, CTRL-C to abort"
raw_input()

out_file = open(to_file, 'w').write(indata)
#out_file.write(indata)

print "Allright, all done."
#from_file.close()
#to_file.close()