# Python_Руководство_my_р4_циклы
# code "p4"

# Упражнение 3. Расход ресурса

from random import randint  # подключение функции из модуля random

total = 100  # запас ресурса
i = 0  # счетчик итераций цикла
while i < 5:
    n = randint(1, 20)  # имитация расхода ресурса
    total = total - n
    i += 1

print("Осталось", total)

# Контроль ресурса – прерывание цикла
total = 100
i = 0
while i < 5:
    n = randint(1, 50)
    total = total - n
    if total < 0:
        total = 0
        break
    i += 1

print("Осталось", total)


# Контроль процесса – выполнился ли цикл полностью?
total = 100
i = 0
while i < 5:
    n = randint(1, 50)  # имитация расхода ресурса
    total = total - n
    if total < 0:
        total = 0
        print("Прерывание процесса")
        break
    i = i + 1
else:
    print("Процесс выполнен полностью")

print("Осталось", total)