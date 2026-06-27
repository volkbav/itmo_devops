# Python_Руководство_my_р4_циклы
# code "p4f"

# Упражнение 1. Использование стандартных математических функций

# Задание 1. Использование встроенных функций
a, b, c = map(int, input('введите 3 числа через пробел ').split())

print(max(a, b, c))


# Задание 2. Использование других функций
import math

help(math)
a = float(input("Введите число: "))
y1 = math.sqrt(a)
y = math.ceil(y1)
print('sqrt(a) = ', y1)
print('sqrt(a) = ', y)
y = math.ceil(math.sqrt(a))
print('sqrt(a) = ', y)