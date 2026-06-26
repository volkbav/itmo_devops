#!/usr/bin/env python3
# Python_Руководство_my_р4_циклы
# code "p4f"

# Упражнение 4 (контрольное). Перемещение файлов в требуемый каталог

from pathlib import Path
from sys import argv

name_dir = argv[1] if len(argv) > 1 else 'temp'
# print(name_dir)

base_dir = Path.cwd()
# print(base_dir)

folder_path = base_dir / name_dir
if not folder_path.exists():
    folder_path.mkdir()


def replace_txt_files(folder_path):
    for f in base_dir.glob('*.txt'):
        path_destination = folder_path / f.name
        f.replace(path_destination)


# создание тестовых файлов закомментировать после тестов


def create_files():

    dir_name = base_dir
    if not dir_name.exists():
        dir_name.mkdir()
    for i in range(5):
        (dir_name / f'file{i}.txt').touch()


# create_files()
replace_txt_files(folder_path)

