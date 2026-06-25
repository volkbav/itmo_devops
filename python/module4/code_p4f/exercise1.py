# Python_Руководство_my_р4_циклы
# code "p4f"

# Упражнение 1. Поиск слова в текстовом файле
import os
from pathlib import Path

# base_dir = Path(__file__).resolve().parent
# print(str(base_dir))

# folder = base_dir + '\\PythonPrim\\Textfiles'
# print(folder)

# выбор пути для win/linux
if os.name == 'posix':
    folder = os.getcwd() + '/PythonPrim/Textfiles'
else:
    folder = os.getcwd() + '\\PythonPrim\\Textfiles'
print(folder)

answ = set()
search = input('Поиск: ')

for filename in os.listdir(folder):
    filepath = os.path.join(folder, filename)
    print(filepath)

