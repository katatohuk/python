# this one is like your scripts with argv
def print_two(*args):
	arg1, arg2 = args
	print "arg1: %r, arg2: %r" % (arg1, arg2)

# ok, that *args is actually pointless, we can just do this
def print_two_again(arg1, arg2):
	print "arg1: %r, arg2: %r" % (arg1, arg2)

# this just takes 1 argument	
def print_one(arg1):
	print "arg1: %r" % arg1

# this doesnt take any arguments
def print_none():
	print "I got nothing."

print_two("Hi, ", "Vasya!")
print_two_again("Hi, ", "Vasya!")
print_one("Hi")
print_none()		