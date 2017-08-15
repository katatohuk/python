from sys import argv

script, filename = argv

txt = open(filename)

print(f"Here is ur {filename}:")
print(txt.read())

print("Type filename again here:")
fileagain = input("> ")

txtagain = open(fileagain)
print(txtagain.read())