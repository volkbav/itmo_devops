# Python_Руководство_my_р5_списки_циклы
# code "p5"

# Упражнение 1. Использование списков

fruits = ['Apple', 'Grape', 'Peach', 'Banan', 'Orange']

def print_list(list_):
    for i in list_:
        print(i)


print_list(fruits)

fruits[1] = fruits[0] = 'Watermelon'
fruits[3] = 'Lemon'

fruits.append('Banan')

if "Apple" in fruits:
    print("В списке есть 'Apple'")
else:
    print("В списке нет 'Apple'")

print(fruits)