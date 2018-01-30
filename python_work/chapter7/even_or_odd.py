number = input("Please neter some number, and I will determine if its even or odd: ")
number = int(number)
# Четное число: число которое делится на 2 без остатка, нечетное - которое делится на 2 с остатком
if number % 2 == 0:
	print("Your number is even")
else:
	print("Your number is odd")