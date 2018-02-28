prompt = "\nTell me smth and I'll repeat it back."
# += add new part of text to existing which is stored in prompt variable
prompt += "\nType 'quit' to end the programm: "

#This wont work with python lower than 3.* version
message = ""
while message != 'quit':
	message = input(prompt)
	print(message)