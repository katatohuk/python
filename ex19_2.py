def cheese_and_crackers(cheese_count,box_of_crackers,sum):
	print(f"You have {cheese_count} cheeses!")
	print(f"You have {box_of_crackers} boxes of crackers!")
	print(f"Totally you have {sum} cheese and crackers!\n")

print("Buddy, lets count your cheese and crackers!")
amount_of_cheese = input("Cheese quantity: ")
amount_of_crackers = input("Cracker boxes quantity: ")
sum_amount = int(amount_of_crackers) + int(amount_of_cheese)

cheese_and_crackers(amount_of_cheese, amount_of_crackers, sum_amount)


