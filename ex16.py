from sys import argv

script, filename = argv

print(f"We're going to erase {filename}.")
print("If u wanna break, press CTRL-C")
print("If u wanna proceed, press Enter")

input("?")

print("Opening the file...")
#Using r+ to open file for reading/writing the same time
target = open(filename, 'r+')

print("Truncating file")
target.truncate()

print("File is empty now. Lets check that, if u dont see any line below - file has been succesfully truncated.")
print(target.read())

print("Now I'm going to ask you 3 lines.")

line1 = input("line1: ")
line2 = input("line2: ")
line3 = input("line3: ")
lines = line1 + "\n" + line2 + "\n" +line3 + "\n"

print("Great. Now I'm going to write them into file")

target.write(lines)

print("Saving file now.")
target.close()

