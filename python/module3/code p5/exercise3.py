# Python_Руководство_my_р5_списки_циклы
# code "p5"

# Упражнение 2. Получение требуемых данных

s = 'ab12c59p7dq'
digits = []
for symbol in s:
    if '1234567890'.find(symbol) != -1:  # find => -1, если не нашел значение
        digits.append(int(symbol))

print(digits)