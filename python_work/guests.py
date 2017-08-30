#! /usr/bin/env python
# -*- coding: utf-8 -*-

#print("Вася")

#Список гостей: если бы вы могли пригласить кого угодно (из живых или умерших) на обед, то кого бы вы пригласили?
#Создайте список, включающий минимум трех людей, которых вам хотелось бы пригласить на обед
#Затем используйте этот список для вывода пригласительного сообщения каждому участнику 

guests = ["Ira", "Vadim", "Sergei"]
#print(guests)
print("Congrats " + guests[0] + " you're invited to the dinner.") 
print("Congrats " + guests[1] + " you're invited to the dinner.") 
print("Congrats " + guests[2] + " you're invited to the dinner.") 
print(str(len(guests)) + " guests will come today on dinner")

# Изменение списка гостей: вы только что узнали, что один из гостей прийти не сможет, поэтому вам придется разослать новые приглашения  Отсутствующего гостя нужно заме- нить кем-то другим 
# Начните с программы из упражнения 3-4  Добавьте в конец программы команду print для вывода имени гостя, который прийти не сможет 
# Измените список и замените имя гостя, который прийти не сможет, именем нового приглашенного 
# Выведите новый набор сообщений с приглашениями – по одному для каждого участ- ника, входящего в список 

print("Unfortunately " + guests[2] + " wont join us :(. I need to find someone else")
guests[2] = ("Artur")
#print(guests)
print("Here is new list!:\n" + 100*"-")
print("Congrats " + guests[0] + " you're invited to the dinner.") 
print("Congrats " + guests[1] + " you're invited to the dinner.") 
print("Congrats " + guests[2] + " you're invited to the dinner.") 
print(str(len(guests)) + " guests will come today on dinner")

#Больше гостей: вы решили купить обеденный стол большего размера  Дополнительные места позволяют пригласить на обед еще трех гостей 
# Начните с программы из упражнения 3-4 или 3-5  Добавьте в конец программы коман- ду print, которая выводит сообщение о расширении списка гостей 
# Добавьте вызов insert() для добавления одного гостя в начало списка 
# Добавьте вызов insert() для добавления одного гостя в середину списка 
# Добавьте вызов append() для добавления одного гостя в конец списка 
# Выведите новый набор сообщений с приглашениями – по одному для каждого участ- ника, входящего в список 
print(100*"-")
print("Ha, I've bought a new bigger dinner table, so can invite 3 more people!")
guests.insert(0, "Ivan")
guests.insert(2, "Artem")
guests.append("Iliya")
print("Congrats " + guests[0] + " you're invited to the dinner.") 
print("Congrats " + guests[1] + " you're invited to the dinner.") 
print("Congrats " + guests[2] + " you're invited to the dinner.")
print("Congrats " + guests[3] + " you're invited to the dinner.") 
print("Congrats " + guests[4] + " you're invited to the dinner.") 
print("Congrats " + guests[5] + " you're invited to the dinner.")  
print(str(len(guests)) + " guests will come today on dinner")
#Now lest sort the list, on permanent basis - you won be able to revert sorting in the list !!!!!
guests.sort()
print(guests)

#Now lets use temporary sorting using function sorted()
#But here we have create example list again
guests = ["Ira", "Vadim", "Sergei"]
print(guests)
print(sorted(guests))

#Lets determine lists lenght
print(len(guests))
