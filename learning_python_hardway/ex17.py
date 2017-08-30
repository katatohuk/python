from sys import argv
from os.path import exists

script, from_file, to_file = argv

print(f"Copying data from {from_file} to {to_file}")

#open file and read it in one line, instead of separate commands to open and then read
in_file = open(from_file).read()

print(f"Here is content of {from_file} file: " + "\n", in_file)

print(f"Lets check if sorce file isnt empty")
if len(in_file) == 0:
	exit("Source file is 0 bytes, so its empty. Please add some data")
else:
	print("Source file is okay")

out_file = open(to_file, 'w').write(in_file)
out_file_read = open(to_file).read()

print(f"Here is content of {to_file}: " + "\n", out_file_read)



