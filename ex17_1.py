from sys import argv, exit
from os.path import exists

script, from_file, to_file = argv

print "Copying from %s to %s file." % (from_file, to_file)

indata = open(from_file).read()

# Lets check if file has some data inside by checking file size in bytes, if its 0, file has no text.
# Please add some into it.
if len(indata) == 0:
    exit("File is empty, please add some text. Bye.")
else:
    print "Ready, hit ENTER to continue, CTRL-C to abort"
raw_input()

out_file = open(to_file, 'w').write(indata)

print "All right, all done."
