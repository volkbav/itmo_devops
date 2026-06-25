# Python_Руководство_my_р4_циклы
# code "p4f"

# Упражнение 1. Поиск слова в текстовом файле
import os
from pathlib import Path

# выбор пути для win/linux
sep = os.path.sep  # разделители для win (\) и для unix (/)
folder = os.getcwd() + f'{sep}PythonPrim{sep}Textfiles'


answ = set()
search = input('Поиск: ')

for filename in os.listdir(folder):
    filepath = os.path.join(folder, filename)
    with open(filepath, 'r', encoding='utf-8') as f:
        for line in f:
            if search in line:
                answ.add(filename)

for i in answ:
    print(i)



