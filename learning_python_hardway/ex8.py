formatter = "{} {} {} {}"
print(formatter.format(1, 2, 3, 4))
print(formatter.format('one', 'two', 'three', 'four'))
print(formatter.format(True, False, False, True))
print(formatter.format(formatter, formatter, formatter, formatter))
print(formatter.format(
		"Here should be some text",
		"Bla bla bla",
		"Hehehehehe",
		"Coll, yeah ?"
	))