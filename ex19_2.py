def read_write(output_file, input_file):
	indata = open(output_file).read()
	print "Reading text from file %s" % output_file
	print "The following text:\n%swill be copied" % indata
	outdata = open(input_file, "w").write(indata)
	print "Writing data to file %s" % input_file

read_write("ex19_out", "ex19_in")