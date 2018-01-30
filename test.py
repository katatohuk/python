from operator import itemgetter, attrgetter

line = "server1,IDP : uat1\
server2,IDP : uat1"
print(line.split(',',1))

dic = {}
for x in line:
#	print(x.split(','))
	a, b = line.split(',',1)
	dic[a] = b

print(dic)

print(sorted(dic, key=itemgetter(0)))


