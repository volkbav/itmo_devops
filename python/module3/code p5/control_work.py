# Python_Руководство_my_р5_списки_циклы
# code "p5"

# Упражнение 4.1 (контрольное) Объем продаж

weekday = [
    "Monday", 
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday", 
    "Saturday", 
    "Sunday"]

# ввод данных
sales = {}
sum_sales = 0
for day in weekday:
    sales[day] = int(input(f'введите кол-во продаж в {day}: '))
    sum_sales += sales[day]


sorted_sales = sorted(sales.items(), key=lambda x: x[1])

for i in sorted_sales:
    print(i)