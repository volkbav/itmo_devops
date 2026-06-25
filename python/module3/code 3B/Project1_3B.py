# задание из Задания_Number_B
# code "3B"

# Project1_3B

import random

# Задание 1

cutoff = random.randint(1, 100)


list_len = random.randint(3, 10)
num_list = []
for i in range(list_len):
    num_list.append(random.randint(1, 100))

print(num_list)

new_list = ['High' if i < cutoff else 'Low' for i in num_list]
print(f'cutoff = {cutoff}\n', new_list)


# Задание 2
import names  # type: ignore # noqa: E402

name_list = [names.get_first_name() for i in range(100)]

A_M_names = []
other_names = []

[(A_M_names if i[0] in "AM" else other_names).append(i) for i in name_list]

print(f'{name_list},\nA and M names\n{A_M_names}, \nother names\n{other_names}')


# Задание 3

cli = "введите 1 слово "
words = []
word = ""
inbox = "not empty"
while inbox != '':
    inbox = input(cli)
    if inbox == "":
        break
    words.append(inbox)
    word += inbox[0]
    cli = 'введите следующее слово '
print(f'{words}, {word}')
