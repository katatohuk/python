message = input("Hey buddy, please enter here some text: ")
print(message)

prompt = "If you tell us who you are, we cant personalize the message you see"
# += add new part of text to existing which is stored in prompt variable
prompt += "\nWhat is your first name?: "
name = input(prompt)
print("\nHello, " + name)




