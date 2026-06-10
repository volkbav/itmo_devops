#!/bin/bash
# code takes from https://habr.com/ru/companies/ruvds/articles/325928/


# for

# list="1 2 3 four five"
# for var in $list
# do
# 	echo $var
# done

for var in first "the second" "the third" "I’ll do it"
do
	echo "This is: $var"
done