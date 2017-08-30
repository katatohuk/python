cars = ['audi', 'vw', 'seat', 'bwm']
print(cars)

#Lets replace first element in the list
cars[0] = 'mercedes'
print(cars)

#Appen will add new element to the end of list
cars.append('hyundai')
print(cars)

#Lets create empty list and later add items
cars = []
print(cars)
cars.append('audi')
cars.append('honda')
cars.append('vw')
print(cars)

#insert will add element to the list in particular position
cars.insert(0, 'kia')
print(cars)

#del will delete particular item from the list, using position index
del cars[0]
print(cars)
