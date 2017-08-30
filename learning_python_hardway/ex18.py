def print2(*args):
	arg1, arg2 = args
	print(f"arg1: {arg1}, arg2: {arg2}")

def print2again(arg1, arg2):
	print(f"arg1: {arg1}, arg2: {arg2}")

def print1(arg1):
	print(f"arg1: {arg1}")

def print0():
	print("I have nothing to print")

print2("Joe","Ivan")
print2again("Kostya","Fedir")
print1("Elvis")
print0()		
