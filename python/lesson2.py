Python 3.14.2 (v3.14.2:df793163d58, Dec  5 2025, 12:18:06) [Clang 16.0.0 (clang-1600.0.26.6)] on darwin
Enter "help" below or click "Help" above for more information.
pow
<built-in function pow>
pow(2,3)
8
pow = 2
pow
2
del pow
pow
<built-in function pow>
 print(bool(10))
SyntaxError: invalid non-printable character U+00A0
print(bool(10))
True
print(bool(0))
False
print(bool( ))
False
a, b =12, 13
a < b
True
r = a < b
r
True
type(r)
<class 'bool'>
(a < b) * 10
10
(a > b) * 10
0
 a = 1
SyntaxError: invalid non-printable character U+00A0
a = 1
b = 1
id(a
   )
4366938080
id(b)
4366938080
a = 257
b = 257
a is b
False
a = 1
b = 1
a is b
True
5 is True
False
4 < 5 is True
False
(4 < 5) is True
True

arr = (1, 2, 3)
arr[0]
1
arr = (1, 2, 3, "as")
arr
(1, 2, 3, 'as')
arr = (1, 2, 3, "as", (1, 2))
arr
(1, 2, 3, 'as', (1, 2))
>>> arr = [1, 2, 3]
>>> arr[3] = 4
Traceback (most recent call last):
  File "<pyshell#40>", line 1, in <module>
    arr[3] = 4
IndexError: list assignment index out of range
>>> arr.append(4)
>>> arr
[1, 2, 3, 4]
>>> arr[3] = 5
>>> arr
[1, 2, 3, 5]
>>> mx = ("tt", (0, 100), 'A', [12, 14, 453], True)
>>> type(mx)
<class 'tuple'>
>>> print(mx)
('tt', (0, 100), 'A', [12, 14, 453], True)
>>> mx
('tt', (0, 100), 'A', [12, 14, 453], True)
>>> mx[3]
[12, 14, 453]
>>> mx[3].append(12)
>>> mx[3]
[12, 14, 453, 12]
>>> mx = ("tt", (0, 100), 'A', [12, 14, 453], True, {a: 1})
>>> mx
('tt', (0, 100), 'A', [12, 14, 453], True, {1: 1})
>>> mx[-1]
{1: 1}
>>> mx[-1].update({b: 2})
>>> mx[-1]
{1: 2}
>>> mx
('tt', (0, 100), 'A', [12, 14, 453], True, {1: 2})
>>> a
1
>>> b
1
