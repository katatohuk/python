cars = 100
space_in_car = 4.0
drivers = 30
passengers = 90
cars_without_drivers = cars - drivers
cars_with_drivers = drivers
carpool_capacity = cars_with_drivers * space_in_car
average_pass_per_car = passengers / cars_with_drivers

print("There're", cars, "cars available.")
print("There're only", drivers, "drivers available.")
print("There will be", cars_without_drivers, "empty cars today.")
print("We can transport", carpool_capacity, "people today.")
print("Totally we have", passengers)
print("We need to put about", average_pass_per_car, "in each car.")