prompt = "\nPlease enter the name if the city you visited."
prompt += "\nType 'quit' to end the programm: "

while True:
	city = input(prompt)

	if city == 'quit':
		break
	else:
		print("I'd love to go to the " + city.title() + " too !")