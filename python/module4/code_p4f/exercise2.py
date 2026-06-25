# Python_Руководство_my_р4_циклы
# code "p4f"

# Упражнение 2 (контрольное). Получение информации о файле

import os

# выбор пути для win/linux
sep = os.path.sep  # разделители для win (\) и для unix (/)
folder = os.getcwd() + f'{sep}PythonPrim{sep}Textfiles'

filepath = os.path.join(folder, 'file.txt')

with open(filepath, 'r', encoding='utf-8') as f:
    data = f.read()

print(data)

letters = sum(map(str.isalpha, data))
print(letters)
words = len(data.split())
print(words)

