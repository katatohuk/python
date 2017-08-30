my_name = 'Parkhomenko Andrii'
my_age = 32
my_height_cm = 192 # cm
my_weight_kg = 95 # kg
#Now lets convert cm to inches and round it with round func
my_height_inch = my_height_cm / round(2.5,1)
##Now lets convert kg to pounds and round it with round func
my_weight_pnd = my_weight_kg / round(0.45,1)
my_eyes = 'Blue'
my_teeth = 'white'
my_hair = 'blonde'

print(f"Lets talk about {my_name}.")
print(f"He's {my_age} years old.")
print(f"He's {my_height_cm}/{my_height_inch} centimiters/inches tall.\nHe's {my_weight_kg}/{my_weight_pnd} kilogramms/pounds heavy.")
print(f"He's got {my_eyes} eyes and {my_hair} hair.")
print(f"His teeth are usually {my_teeth} depending on the coffee and cigarettes.")

total = my_age + my_height_cm + my_weight_kg

print(f"If I add {my_age}, {my_height_cm} and {my_weight_kg} I get {total}.")