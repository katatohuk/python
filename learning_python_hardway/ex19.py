def cheese_and_crackers(cheese_count,box_of_crackers):
	print(f"You have {cheese_count} cheeses!")
	print(f"You have {box_of_crackers} boxes of crackers!\n")

print("We cant give the function numbers directly:")
cheese_and_crackers(20, 30)

print("or use variables from our script:")
amount_of_cheese = 10
amount_of_crackers = 50
cheese_and_crackers(amount_of_cheese, amount_of_crackers)

print("We can eve do some math inside:")
cheese_and_crackers(10 + 20, 5 + 6)

print("And we can combine variables and math:")
cheese_and_crackers(amount_of_cheese + 100, amount_of_crackers + 1000)
