servers = {
	'mdf': {
	'environment': 'DEVX',
	'hostname': 'server1',
	'component': 'DAS',
	'location': 'London',
	},
	'orator': {
	'environment': 'SIT',
	'hostname': 'server2',
	'component': 'WC',
	'location': 'London',
	},
	'idp': {
	'environment': 'SIT',
	'hostname': 'server3',
	'component': 'Extractor',
	'location': 'London',
	},
}
print("App | Env | Hostname | Component | Location ")
for app, app_info in servers.items():
	#print("\nApp: " + app.upper())
	detailied_info = app_info['environment'] + " | " + app_info['hostname'] + " | " \
	+ app_info['component'] + " | " + app_info['location']
	print(app.upper() + " | " + detailied_info)
