# задание из Задания_Number_B
# code "6B"

# Project 1_6B

from datetime import date
from pathlib import Path

import app_logger

FILES_LIST = ['data_01_.csv', 'data_01.csv', 'data_02.csv']

logger = app_logger.get_logger(__name__)


# path to the files 
base_dir = Path(__file__).parent.resolve()


# test print
print(base_dir)
logger.info('test info')

logger.warning("test warning")
# ---