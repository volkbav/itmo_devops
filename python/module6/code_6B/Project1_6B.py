# задание из Задания_Number_B
# code "6B"

# Project 1_6B

from datetime import datetime
from pathlib import Path

import app_logger, csv

FILES_LIST = ['data_01_.csv', 'data_01.csv', 'data_02.csv']

logger = app_logger.get_logger(__name__)


# path to the files 
base_dir = Path(__file__).parent.resolve()


def read_csv(file: str) -> list:
    # try to open file
    try:
        with open(file) as f:
            reader = csv.reader(f)
            logger.info(f'open file {f}')
            headers = next(reader)
            data = []
            data.append(headers)
            for row in reader:
                data.append(row)
            return data
    except FileNotFoundError:
        logger.warning("File not found")


def write_csv(data: list):
    file_name = str(datetime.now()) + ' backup.csv'
    with open(file_name, 'w+') as f:
        writer = csv.writer(f)
        for row in data:
            writer.writerow(fow)


print(read_csv('data_01_.csv'))
print(write_csv(read_csv('data_01_.csv')))
# def copy_data(file: str):

    
        
        



# test print
# print(base_dir)
# logger.info('test info')

# logger.warning("test warning")
# ---