# Python_Руководство_my_р4_циклы
# code "p4"

# Упражнение 4. Сумма цифр числа

num = input('Введите число для подсчета суммы цифр: ')
sumIt = 0
for it in num:
    sumIt += int(it)
    
print(f"Сумма цифр числа {num} равна {sumIt}")