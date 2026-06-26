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


def add_folder(base_dir, folder_name):
    folder_name = base_dir / folder_name
    if not folder_name.exists():
        folder_name.mkdir()
    return folder_name


my_folder = add_folder(base_dir, 'my_folder')

file1 = my_folder / 'file1.txt'
file1.touch()
(my_folder / 'file2.txt').touch()
my_folder.joinpath('image.png').touch()

images = add_folder(my_folder, 'images')

for f in my_folder.glob('*.png'):
    path_destination = images / f.name
    f.replace(path_destination)

