# Python_Руководство_my_р5_списки_циклы
# code "p5"

# Упражнение 3. Применение словаря для хранения данных

user1 = {
    'firstname': 'Ivan', 
    'lastname': 'Петров',
    'age': 19
}

print(user1)

fname = input('Enter your firstname: ')
lname = input('Enter your lastname: ')
age = int(input('Enter your age: '))

user2 = dict(firstname=fname, lastname=lname, age=age)

print(user2)

users = []
users.append(user1)
users.append(user2)

print(users)