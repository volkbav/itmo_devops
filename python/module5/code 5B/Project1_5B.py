# задание из Задания_Number_B
# code "5B"

# Project 1_5B

# 1
def temperature_avg(temperature: list):
    temp = [i for i in temperature if i != None]
    avg_temp = sum(temp) / len(temp)
    print(avg_temp)


temperature_avg([1, 2, None])


# 2
def negative_positive(*args):
    negative = []
    positive = []
    for i in args:
        if i < 0:
            negative.append(i)
        elif i > 0:
            positive.append(i)
        else:
            continue
    return (sorted(negative, reverse=True), sorted(positive))


print(negative_positive(-1, 0, 1, -2, 3, 2))


# 3
def sqrt1(a, b):
    return a ** b


def sqrt2(a, b):
    acc = 1
    while b > 0:
        acc *= a
        b -= 1
        sqrt2(a, b)
    return acc


print(sqrt1(5, 2))

print(sqrt2(5, 3))