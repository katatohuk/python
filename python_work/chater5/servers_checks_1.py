# Chek servers by the list
# Env server list is hardcoded in this scrip, used dictionary "envs" here
#  

#script, input_server = argv
#print(input_server + "\n")

# Can be done in this way as well
f = open("envs.txt").read().splitlines()
#f = open("list.txt").readlines()
#print(f)
#envs = list(f)
#print(envs)
in_file = open("input.txt").read().splitlines()
input_list = list(in_file)
#print(input_list)
env_file = open("envs.txt").read()
#print(env_file)

#env = {}
#print(env_file.split())


#for line in env_file:
    	#print(a,b)
	#env['a'] = b

#print(env)
#envs = dict(key, value.strip())

#print(envs)



#if input_server in envs:
#	print("Server is in the list")

envs = {
'server1': 'IDP : uat1',
'server2': 'IDP : uat1',
'server3': 'IDP : uat1',
'server4': 'IDP : uuat',
'server5': 'IDP : uuat',
'server6': 'IDP : uuat',
'server7': 'IDP : uat3',
'server8': 'IDP : uat3',
'server9': 'IDP : uat3',
'server10': 'MDF : devx',
'server11': 'MDF : devx',
'server12': 'MDF : devx',
'server13': 'MDF : qax',
'server14': 'MDF : qax',
'server15': 'MDF : qax',
'server16': 'MDF : uatx',
'server17': 'MDF : uatx',
'server18': 'MDF : uatx',
}

#print("\n")
#print(envs)
#idp = sorted(idp.items(), key=lambda item: item[0])
#print(idp)


#envs = [idp, mdf]
#print(envs)

for key, value in envs.items():
	#print("\n" + key)
	#print(value)
	if key in input_list:
    		print(value + " : " + key)

#for key, value in mdf.items():
#	#print("\n" + key)
#	#print(value)
#	if key in input_list:
#    		print("MDF : " + key + " : " + value)


#for key, value in mdf.items():
#	print("\n" + key)
#	print(value)
#	if value in input_list:
#    		print(value)
#    		print("MDF : " + key)


#for value in input_list:
#	if value in idp:
#    		print("IDP : " + key)

#for key, value in mdf.items():
#	if value in input_list:
#    		print("MDF : " + key)

