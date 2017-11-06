favourite_languages = {
	'jen': ['python', 'ruby'],
	'sarah': ['c'],
	'edward': ['ruby', 'go'],
	'phil': ['python', 'haskel'],
	}

for name, languages in favourite_languages.items():
	print("\n" + name.title() + "'s favourite languages are:")
	for language in languages:
		print("\t" + language.title())