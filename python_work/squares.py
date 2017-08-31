#! /usr/bin/env python
# -*- coding: utf-8 -*-

#Список квадратов всех целых числе от 1 до 100
squares = []
for value in range(1,101):
	square = value**2
	squares.append(square)

print(squares)

#Или короче
squares = []
for value in range(1,101):
	squares.append(value**2)
print(squares)