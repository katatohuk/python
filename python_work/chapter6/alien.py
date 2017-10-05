#Set dictionary and ready keys from it
alien_0 = {'color': 'green', 'points': 5}
#print(alien_0)
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


