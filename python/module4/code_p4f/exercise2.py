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

letters = sum(map(str.isalpha, data))
words = len(data.split())
lines = data.count('\n') + 1
print(f'Input file contains:\n{letters} letters\n{words} words\n{lines} lines')