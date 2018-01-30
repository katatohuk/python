def newline():
	print("\n")

#Set dictionary and ready keys from it
alien_0 = {'color': 'green', 'points': 5}
#print(alien_0)
newline()
print(alien_0['color'])
print(alien_0['points'])

#Lets add new keys/values to our dic
alien_0['x_position'] = 0
alien_0['y_position'] = 25
print(alien_0)

#Lets create empty dic
alien_0 = {}
#And add new items
alien_0['color'] = 'green'
alien_0['points'] = 5
print(alien_0)

#Lets create dic and then modify existing value
alien_0 = {'color': 'green'}
print("Alien color is set to " + alien_0['color'])
alien_0['color'] = 'yellow'
#And check that was modified from green to yellow
print("Alien color has been changed from green to " + alien_0['color'])

#Lets create 3 dicts and then merge them into 1 list
alien_0 = {'color': 'green'}
alien_1 = {'color': 'yellow'}
alien_2 = {'color': 'white'}
alien = [alien_0, alien_1, alien_2]
print(alien)


#Lets create empty list
aliens = []
newline()
#Lets generate 30 aliens
for alien in range(30):
	new_alien = {'color': 'green', 'points': 5, 'speed': 'slow'}
	aliens.append(new_alien)

#Lets print first 5 aliens
for alien in aliens[:5]:
	print(alien)

#lets count how many aliens are in the list
print(str(len(aliens)))