from sys import argv

script, username = argv
promt = '> '

print(f"Hi {username}, I'm the {script} script.")
print(f"I'd like to ask you a few questions.")
print(f"Do you like me {username} ?")
likes = input(promt)

print(f"Where do you live {username} ?")
lives = input(promt)

print(f"What kind of computer do you have ?")
comp = input(promt)

print(f"""
Alright, so you said you "{likes}" about liking me.
You line in {lives}. Not sure where that is.
And you have a {comp} computer. Cool ! 
""")