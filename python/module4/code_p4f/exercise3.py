# Python_Руководство_my_р4_циклы
# code "p4f"

# Упражнение 3. Применение модуля pathlib для создания файлов и папок
from pathlib import Path

'''
Так как "засорять" домашний каталог - плохая идея, в задании будет
использоваться привязка к расположению данного файла
'''

# resolve - для получения полного пути к текущему каталогу
base_dir = Path(__file__).parent.resolve()

home = Path.home()  # получение ссылки для домашнего каталога
print(home)  # проверка, что получили нужный каталог

my_folder = base_dir / 'my_folder'
if not my_folder.exists():
    my_folder.mkdir()


