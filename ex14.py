from sys import argv
script, user_name, age = argv

promt = ':: '

print "Hi %s, I'm the script %s" % (user_name, script)
print "I'd like to ask u a few questions"
print "Do you like me %s" % user_name
likes = raw_input(promt)

print "Where do you live %s?" % user_name
lives = raw_input(promt)

print "What kind of computer do you have?"
computer = raw_input(promt)

print """
Alright, so u said %r about liking me.
You live in %s and I know u're %s years old.
Hehe, dont be scared, I know smth about u already.
Anyway I'm not sure where %s is.
And you have a %s computer. Nice.
""" % (likes, lives, age, lives, computer)