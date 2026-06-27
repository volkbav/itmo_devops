# Python_Руководство_my_р4_циклы
# code "p4f"

# Упражнение 3 (контрольное). Реализация функций

# Упражнение 2. Определение наибольшего общего делителя
# a = int(input('Задайте первое число '))
# b = int(input('Задайте второе число '))


def nod_(a, b):
    while a != b:
        if a > b:
            a -= b
        else:
            b -= a
        nod = a
    print(f'НОД = {nod}')


# Наибольшее из трех чисел

# data = list(map(int, input('введите 3 числа через пробел: ').split()))


def max_num(data):
    for i in data:
        if (i < max(data)) and (i != min(data)):
            print(
                f'максимальное число: {max(data)}, среднее число: {i},',
                f'минимальное число {min(data)}'
            )


# високосный ли год
# current_date = datetime.date.today()
# year = current_date.year   


def leap(year):
    if (year % 4 == 0) and (year % 100 != 0) or (year % 400 == 0):
        print('год високосный')
    else:
        print('год не високосный')


# вызов функций


a = int(input('Задайте первое число '))
b = int(input('Задайте второе число '))
nod_(a, b)

data = list(
    map(int, input('введите 3 числа через пробел: ').split())
)
max_num(data)

year = int(input('Введите год '))
leap(year)

