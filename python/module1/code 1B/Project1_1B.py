# задание из Задания_Number_B
# code "1B"

# Project1_1
name, surname = map(str, input('введите ваше Имя и Фамилию: ').split())
name, surname = name.title(), surname.title()
login = surname + name

print(f"{surname} {name}: {login}")