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
print(f'cutof = {cutoff}\n', new_list)

