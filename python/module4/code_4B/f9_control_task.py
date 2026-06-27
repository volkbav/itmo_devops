'''
Контрольное задание вместо 4В
Напишете код, который находит все yaml файлы в проекте, проверяет, 
не пустые ли они, и загружает их настройки
и загрузите в файл json или yaml
Добавьте код в указанные места
'''

# Запускать из текущей папки, так как в этом задании
# не использовался путь до текущего файла: Path(__file__).parent.resolve()

import json
from pathlib import Path

import yaml

search_dir = './data'  # путь к папке вашего проекта
combined_settings = {}
dir_path = Path(search_dir)

# Ищем все файлы yaml рекурсивно
for file in dir_path.glob('*.yaml'):  # rglob - будет искать в подкаталогах
    # Проверяем, что это файл и он не пустой (размер в байтах > 0)
    if file.is_file() and file.stat().st_size > 0:
        print(file.name.split('.')[0], file.stat().st_size)

        with open(file, "r", encoding="utf-8") as f:
            # Используем имя файла без расширения в качестве ключа
            config = yaml.safe_load(f)
            combined_settings.update({
                file.name.split('.')[0]: config
            })

print(combined_settings)
# # Запись данных в JSON-файл
with open("combined_settings.json", "w", encoding="utf-8") as file:
    json.dump(combined_settings, file, indent=4)

# Запись в YAML-файл
with open("combined_settings.yaml", "w", encoding="utf-8") as file:
    yaml.safe_dump(combined_settings, file)