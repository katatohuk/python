#Below will show only odd numbers in range of 1-11

current_no = 0
while current_no <= 10:
	current_no += 1
	if current_no % 2 == 0:
		continue
	print(current_no)