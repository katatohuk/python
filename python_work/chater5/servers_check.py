from sys import argv

#script, input_server = argv
#print(input_server + "\n")

# Can be done in this way as well
f = open("envs.txt").read().splitlines()
#f = open("list.txt").readlines()
#print(f)
envs = list(f)
#print(envs)
in_f = open("input.txt").read().splitlines()
input_list = list(in_f)
#print(input_list)


#if input_server in envs:
#	print("Server is in the list")

for value in input_list:
	if value in envs: #and input_server == 'server4': 
		 print(f"Hostname {value} is in envs list")
