# Python_Руководство_my_р4_циклы
# code "p4"

# Контрольное задание
from random import randint

total = 100
i = 0
for i in range(5):
    print(i)
    n = randint(1, 50)  # имитация расхода ресурса
    total = total - n
    if total < 0:
        total = 0
        print("Прерывание процесса")
        break
else:
    print("Процесс выполнен полностью")

print("Осталось", total)