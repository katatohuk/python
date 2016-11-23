from sys import argv
from os.path import exists

script, from_file, to_file = argv

print "Copyin from %s to %s file." % (from_file, to_file)

in_file = open(from_file)
indata = in_file.read()

print "The input file is %s bytes long" % len(indata)

print "Does the output filr exist? %r" % exists(to_file)
print "Ready, hit ENTER to continue, CTRL-C to abort"
raw_input()

out_file = open(to_file, 'w')
out_file.write(indata)

print "Allright, all done."
out_file.close()
in_file.close()