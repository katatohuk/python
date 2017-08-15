# -*- coding: utf-8 -*-
import config
import telebot
import os

bot = telebot.TeleBot(config.token)
osname = os.uname()
#print(osname)

@bot.message_handler(commands=['start', 'help'])
def send_welcome(message):
	bot.reply_to(message, "Howdy, how are you doing?")

@bot.message_handler(commands=['osname'])
def send_message(message): # Название функции не играет никакой роли, в принципе
    bot.send_message(message.chat.id, message.text, message.osname)
 

#@bot.message_handler(content_types=["text"])
#def repeat_all_messages(message): # Название функции не играет никакой роли, в принципе
#    bot.send_message(message.chat.id, message.text)



if __name__ == '__main__':
    bot.polling(none_stop=True)