# Python_Руководство_my_р2_данные
# code "p3"

# Упражнение 3.1 (контрольное). Наибольшее из трех чисел

data = list(map(int, input('введите 3 числа через пробел: ').split()))

for i in data:
    if (i < max(data)) and (i != min(data)):
        print(
            f'максимальное число: {max(data)}, среднее число: {i},',
            f'минимальное число {min(data)}'
        )
