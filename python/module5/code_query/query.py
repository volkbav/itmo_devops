# code "query"
'''
Напишите функцию, которая принимает произвольное количество именованных 
аргументов и формирует из них строку запроса.

Аргументы в строке запроса должны быть отсортированы в алфавитном порядке.

Примеры вызова:
print(make_query(category='books', genre='thriller', author='Stephen_King'))
print(make_query(name='Егор', last_name='Тимохин', age=25, occupation='дизайнер'

Вывод:
author=Stephen_King&category=books&genre=thriller
age=25&last_name=Тимохин&name=Егор&occupation=дизайнер
'''


def make_query(**kwargs):
    query = ''
    kwargs = sorted(kwargs.items(), key=lambda x: x[0])
    for k, v in kwargs:
        query += f'{k}={v}_'
    return query.rstrip('_')


print(make_query(category='books', genre='thriller', author='Stephen_King'))
print(
    make_query(name='Егор', last_name='Тимохин', age=25, occupation='дизайнер')
)
