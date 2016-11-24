#Lets write function to open file and then write some stuff in it.
#This is the same was done in ex17_1.py but using a function

def read_write(output_file, input_file):
	indata = open(output_file).read()
	print "Reading text from file %s" % output_file
	print "The following text:\n%swill be copied" % indata
	outdata = open(input_file, "w").write(indata)
	print "Writing data to file %s" % input_file

read_write("ex19_out", "ex19_in")