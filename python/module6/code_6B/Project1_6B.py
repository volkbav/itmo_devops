# задание из Задания_Number_B
# code "6B"

# Project 1_6B

import csv
from datetime import datetime

import app_logger

FILES_LIST = ['data_01_.csv', 'data_01.csv', 'not_exist.csv', 'data_02.csv']

logger = app_logger.get_logger(__name__)


def read_csv(file: str) -> list:
    # try to open file
    data = []
    try:
        with open(file) as f:
            reader = csv.reader(f)
            logger.info(f'open file {f}')
            headers = next(reader)
            data.append(headers)
            for row in reader:
                data.append(row)
            return data
    except FileNotFoundError:
        logger.warning(f"File not found: {file}")
    return []


def write_csv(data: list, name='_backup'):
    if not data:
        return
     
    file_name = datetime.now().strftime("%Y%m%d_%H%M%S") + f'_{name}.txt'
    with open(
        file_name, 
        'w',
        encoding="utf-8"
    ) as f:
        # writer = csv.writer(f)
        for row in data:
            f.write(','.join(row) + '\n')
        logger.info(f"Copied {name} successfully")
   

def copy_files(files: list):
    for file in files:
        msg = str(datetime.now()) + f' start copy file {file}'
        logger.info(msg)
        write_csv(read_csv(file), file)
        

copy_files(FILES_LIST)

# test print
# print(read_csv('data_01_.csv'))
# print(write_csv(read_csv('data_01_.csv')))
# ---