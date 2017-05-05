#using urllib.request lib
import urllib.request
import json

get_updates = 'https://api.telegram.org/bot{}/getUpdates?offset={}'
get_updates1 = 'https://api.telegram.org/bot{}/getUpdates'
send_message = 'https://api.telegram.org/bot{}}/sendMessage?chat_id={}}&text={}'
bot_token = '364739074:AAEgCaz6bEk9RbA3VnHJkMutgtonCtVzy3M'

#def telegrem_get_updates():
update_id = 0

r = urllib.request.urlopen(get_updates1), bot_token#(bot_token, update_id))
#response = json.loads(r)
#print (response)