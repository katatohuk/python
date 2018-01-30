prompt = "\nTell me smth and I'll repeat it back."
prompt += "\nType 'quit' to end the programm: "

active = True
while active:
	message = input(prompt)
	
	if message == 'quit':
		active = False
	else:
		print(message)	