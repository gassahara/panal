#!/usr/bin/env python3
import os
import glob
from telegram import ReplyKeyboardMarkup, ReplyKeyboardRemove, Update
from telegram.ext import (
    Updater,
    CommandHandler,
    MessageHandler,
    Filters,
    ConversationHandler,
    CallbackContext,
)

CONSULTA, PAR, OPCION =  range(3)
reply_par = [['OpcionMasEstable']]
files = glob.glob('./*RSI', recursive=False)
anadir=""
regexl=reply_par[0][0]
for filename in files:
    anadir=filename[2:-3]
    print(anadir)
    reply_par[0].append(anadir)
    regexl += '|' + anadir
reply_keyboard = [['RSI', 'RS', 'OpcionMasEstable']]
print(regexl)
def start(update: Update, context: CallbackContext) -> int:
    update.message.reply_text('Hola! Por Favor coloca tu consulta, para una lista de las consultas disponibles escribe /lista',
    reply_markup=ReplyKeyboardMarkup(
        reply_keyboard, one_time_keyboard=True, input_field_placeholder='RSI/RS/OpcionMasEstable'
    ),
    )
    return PAR

def par(update: Update, context: CallbackContext) -> int:
    print("<" + update.message.text + ">")
    if (update.message.text == "OpcionMasEstable"): #par2(Update, CallbackContext)
        files = glob.glob('./*RS', recursive=False)
        n=99
        s=""
        for filename in files:
            f = open(filename, "rb")
            f.seek(-2, os.SEEK_END)
            while f.read(1) != b'\n':
                f.seek(-2, os.SEEK_CUR)
            last_line = f.readline().decode()
            f.close()
            if(float(last_line) < n):
                n=float(last_line)
                s=filename
                print(s)
            print(last_line)
            f = open(s, "rb")
            f.seek(-2, os.SEEK_END)
            while f.read(1) != b'\n':
                f.seek(-2, os.SEEK_CUR)
            last_line = f.readline().decode()
        update.message.reply_text(s[2:-2] + " RS: " + last_line)
        return ConversationHandler.END
    else:
        update.message.reply_text('Por Favr selecciona un par para averiguar el RSI actual.',reply_markup=ReplyKeyboardMarkup(reply_par, one_time_keyboard=True, input_field_placeholder=' '),)
    return OPCION

def par2(update: Update, context: CallbackContext) -> int:
    print("A")
    files = glob.glob('./*RS', recursive=False)
    n=99
    s=""
    for filename in files:
        f = open(filename, "rb")
        f.seek(-2, os.SEEK_END)
        while f.read(1) != b'\n':
            f.seek(-2, os.SEEK_CUR)
        last_line = f.readline().decode()
        f.close()
        if(float(last_line) < n):
            n=float(last_line)
            s=filename
            print(s)
        print(last_line)
    f = open(s, "rb")
    f.seek(-2, os.SEEK_END)
    while f.read(1) != b'\n':
        f.seek(-2, os.SEEK_CUR)
    last_line = f.readline().decode()
    update.message.reply_text(filename[2,-3] + " RS: " + last_line)
    return ConversationHandler.END

def lee(update: Update, context: CallbackContext) -> int:
    print(update.message.text+"RSI")
    f = open(update.message.text+"RSI", "rb")
    f.seek(-2, os.SEEK_END)
    while f.read(1) != b'\n':
        f.seek(-2, os.SEEK_CUR)
    last_line = f.readline().decode()
    f.close()
    print(last_line)
    update.message.reply_text(last_line)
    return ConversationHandler.END

def lee2(update: Update, context: CallbackContext) -> int:
    print(update.message.text+"RS")
    f = open(update.message.text+"RS", "rb")
    f.seek(-2, os.SEEK_END)
    while f.read(1) != b'\n':
        f.seek(-2, os.SEEK_CUR)
    last_line = f.readline().decode()
    print(last_line)
    update.message.reply_text(last_line)
    user = update.message.from_user
    return ConversationHandler.END

def cancel(update: Update, context: CallbackContext) -> int:
    """Cancels and ends the conversation."""
    user = update.message.from_user
    update.message.reply_text(
        'Cancel', reply_markup=ReplyKeyboardRemove()
    )

    return ConversationHandler.END


def main() -> None:
    updater = Updater("1950313106:AAEQrSo-r2ptxC1rlHmlOsr6u0BBK2y5izA")

    dispatcher = updater.dispatcher

    conv_handler = ConversationHandler(
        entry_points=[CommandHandler('start', start)],
        states={
            PAR: [MessageHandler(Filters.regex('^(RSI|RS|OpcionMasEstable)$'), par)],
            OPCION: [MessageHandler(Filters.regex('^(' + regexl  + ')$'), lee)],
            },
        fallbacks=[CommandHandler('cancel', cancel)],
    )

    dispatcher.add_handler(conv_handler)
    updater.start_polling()
    updater.idle()

if __name__ == '__main__':
    main()

