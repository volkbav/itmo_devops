#!/usr/bin/env python3
# Python_Руководство_my_р4_циклы
# code "p4f"

# Упражнение 4 (контрольное). Перемещение файлов в требуемый каталог

from pathlib import Path
from sys import argv

name_dir = argv[1] if len(argv) > 1 else 'trash'
# print(name_dir)

base_dir = Path.cwd()
# print(base_dir)

folder_name = base_dir / name_dir
if not folder_name.exists():
    folder_name.mkdir()

# создание тестовых файлов закомментировать после тестов
# BEGIN CREATING TEST FILES
for i in range(5):
    (folder_name / f'file{i}.txt').touch()
