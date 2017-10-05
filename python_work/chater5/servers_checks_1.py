from sys import argv

#script, input_server = argv
#print(input_server + "\n")

# Can be done in this way as well
f = open("envs.txt").read().splitlines()
#f = open("list.txt").readlines()
#print(f)
#envs = list(f)
#print(envs)
in_f = open("input.txt").read().splitlines()
input_list = list(in_f)
#print(input_list)


#if input_server in envs:
#	print("Server is in the list")

idp = {
'uat1': 'server1',
'uat1': 'server2',
'uat1': 'server3',
'uat2': 'server4',
'uat2': 'server5',
'uat2': 'server6',
'uat3': 'server7',
'uat3': 'server8',
'uat3': 'server9',
}

mdf = {
'devx': 'server10',
'devx': 'server11',
'devx': 'server12',
'qax': 'server13',
'qax': 'server14',
'qax': 'server15',
'uatx': 'server16',
'uatx': 'server17',
'uatx': 'server18',	
}


for key, value in idp.items():
	if value in input_list:
    		print("IDP : " + key)

for key, value in mdf.items():
	if value in input_list:
    		print("MDF : " + key)

