list = open("list.txt").readlines()
for server in list:
	print(server, end=' ')

f = open("list.txt")
for line in f:
	print(line, end=' ')

