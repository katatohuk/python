#Lets write function to open file and then write some stuff in it.
#This is the same was done in ex17.py but using a function

def read_write(output_file, input_file):
	indata = open(output_file).read()
	print(f"Reading text from file {output_file}")
	print(f"The following text will be copied :\n", indata)
	outdata = open(input_file, "w").write(indata)
	print(f"Writing data to file {input_file}")

read_write("ex19_out", "ex19_in")