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

#remove moethod will delete particular item from the list, by value
print("Removing 'honda' from the list using remove method")
print(100 * "-")
print(cars)
cars.remove('honda')
print(cars)

#pop method will delete last item from the list but u'll be able to use it later
cars = ['audi', 'vw', 'seat', 'bwm']
print(cars)
popped_car = cars.pop()
print(cars)
print(popped_car)

cars = ['audi', 'vw', 'seat', 'bwm']
expensive_car = "audi"
cars.remove(expensive_car)
print(expensive_car.title() + " is too expensive for me, removing from the list")

