import requests

url = "https://api.telegram.org/bot364739074:AAEgCaz6bEk9RbA3VnHJkMutgtonCtVzy3M/"

def get_updates_json(requests):
	response = requests.get(request + 'getUpdates')
	return response.json()

def last_update(data):
	results = data['result']
	total_updates = len(results) - 1
	return results[total_updates]
		