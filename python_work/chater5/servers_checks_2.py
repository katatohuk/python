
f = open("envs.txt").read().splitlines()
in_file = open("input.txt").read().splitlines()
input_list = list(in_file)
#print(input_list)
env_file = open("envs1.txt").read().splitlines()
#print(env_file)


#splits = env_file.split(',')
#print(splits)
#print(len(splits))

envs = {}
for line in env_file:
	#print(line.split(',',1))
	a, b = line.split(',',1)
	envs[a] = b
	#print(envs)

#print("\n")
#print(envs)
#print(envs['server1'])

for key, value in envs.items():
	#print("\n" + key)
	#print(value)
	if key in input_list:
    		print(value + " : " + key)


