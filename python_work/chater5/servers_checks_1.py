# Chek servers by the list
# Env server list is hardcoded in this scrip, used dictionary "envs" here
#  

f = open("envs.txt").read().splitlines()
in_file = open("input.txt").read().splitlines()
input_list = list(in_file)
env_file = open("envs.txt").read()

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

for key, value in envs.items():
	#print("\n" + key)
	#print(value)
	if key in input_list:
    		print(value + " : " + key)