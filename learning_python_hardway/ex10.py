import os

tabby_cat = "\tI'm tabbed in."
persian_cat = "I'm split\non a line."
backslash_cat = "I'm \\ a \\ cat. "
name = os.name, os.getlogin(), os.getcwd()
fat_cat = """
I'll do a list:
\t* Cat food
\t* Fishies
\t* Catnip\n\t* Grass
"""

print(name)
print(tabby_cat)
print(persian_cat)
print(backslash_cat)
print(fat_cat)