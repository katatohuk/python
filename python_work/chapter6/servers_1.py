servers = {
	'mdf': {
		'DEVX': {
			'hostname': 'server1',
			'component': 'DAS',
			'location': 'London',
				},
		    },
	
	'orator': {
		'SIT': {
			'environment': 'SIT',
			'hostname': 'server2',
			'component': 'WC',
			'location': 'London',
			    },		
			},
	'idp': {
	'environment': 'SIT',
	'hostname': 'server3',
	'component': 'Extractor',
	'location': 'Stamford',
	},
		}

for app, env in servers.items():
	#print servers.keys()
	print servers.values()
	#print("\nApplication: " + app.upper())
	
	
	
