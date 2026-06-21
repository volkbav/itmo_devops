# задание из Задания_Number_B
# code "p2list"

# Списки

'''1. Создайте список произвольных чисел, например:
list1 = [82,8,23,97,92,44,17,39,11,12]'''
list1 = [12, 342, 453, 54, 'qwerty']
print(list1)


'''2. Примените команду dir для просмотра методов работы со списками
(dir(list)).'''
# print(dir(list))


'''3. Вызовите справку (с помощью команды help) для методов insert, append,
sort, remove, reverse.'''
# help(list.insert)
# help(list.append)
# help(list.sort)
# help(list.remove)
# help(list.reverse)


'''4. Измените значения элементов списка (по вашему усмотрению) с помощью
операции индексирования.'''
list1[0] = 'new'
print(f'new list: {list1}')


'''5. Добавьте новый элемент в конец списка.'''
list1.append('new last element')
print(f'new last element: {list1}')


'''6. Добавьте новый элемент в произвольную (на ваше усмотрение) позицию
списка.'''
list1.insert(1, 'new second element')
print(f'new second element: {list1}')


'''7. Удалите элемент из списка по известной позиции.'''
list1.remove('new')
print(f'removed first element: {list1}')


'''8. Удалите последний элемент из списка'''
list1.pop()
print(f'remove last element by "pop()": {list1}')

list1.remove(list1[-1])
print(f'remove last element ("qwerty") by "remove()": {list1}')


# Сортировка элементов списка
list1 = [1 , 23, 43, 673]
print(f'list: {list1}')
list1.sort(reverse=True)
print(f'sorted list: {list1}')

list2 = [3, 5, 6, 2, 33, 6, 11]
lis = sorted(list2)
print(f'list2 = {list2}, lis = {lis}')


# Кортежи
'''1. Примените команду dir для просмотра методов работы со списками
(dir(tuple)).'''
# print(dir(list))


'''2. Вызовите справку (с помощью команды help) для методов index, count.'''
# help(tuple.index)
# help(tuple.count)


'''3. Создайте кортеж произвольных чисел, например:'''
seq = (2, 8, 23, 97, 92, 44, 17, 39, 11, 12)


'''4. Определите, что возвращают команды:'''
print(seq.count(8))  # количество вхождений числа 8 = 1
print(seq.index(44))  # индекс числа 44 = 5


'''5. Преобразуйте кортеж к типу «список»:'''
listseq = list(seq)


'''6. С помощью команды type(listseq) проверьте правильность преобразования.'''
print(type(listseq))  # <class 'list'>


'''7. Проверьте работу основных методов, применяемых к списку для
преобразованного «кортежа».'''
listseq[0] = 'new'
print(f'new list: {listseq}')

listseq.append('new last element')
print(f'new last element: {listseq}')

listseq.insert(1, 'new second element')
print(f'new second element: {listseq}')

listseq.remove('new')
print(f'removed first element: {listseq}')

listseq.remove(listseq[-1])
print(f'remove last element ("qwerty") by "remove()": {listseq}')
