
#using requests lib
import requests
import json
import time


r = requests.get('https://api.telegram.org/bot364739074:AAEgCaz6bEk9RbA3VnHJkMutgtonCtVzy3M/getUpdates')
#print r
#print r.text
r = r.text
#print "Here is JSON returened: ",r
parsed_r = json.loads(r)
#print parsed_r
result = parsed_r['result']
print result

#print('Here is result:'.format(text))
