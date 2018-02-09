prompt = "\nTell me smth and I'll repeat it back."
# += add new part of text to existing which is stored in prompt variable
prompt += "\nType 'quit' to end the programm: "


message = ""
while message != 'quit':
	message = input(prompt)
	
	if message != 'quit':
		print(message)