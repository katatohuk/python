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

for app, app_info in servers.items():
	print("\nApplication: " + app.upper())
	detailied_info = app_info['environment'] + " : " + app_info['hostname'] + " : has " \
	+ app_info['component'] + " component which is located in " + app_info['location']
	print(detailied_info)
