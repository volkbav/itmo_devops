#!/bin/bash
# code takes from https://habr.com/ru/companies/ruvds/articles/325928/


# for

# list="1 2 3 four five"
# for var in $list
# do
# 	echo $var
# done

# for var in first "the second" "the third" "I’ll do it"
# do
# 	echo "This is: $var"
# done

# file="file_habr"
# IFS=$'\n'
# for var in $(cat $file)
# do
#     echo " $var"
# done


# Обход файлов в директории
# dir=$HOME
# for file in $dir/* # в оригинале /home/likegeeks/*
# do
#     if [ -d "$file" ]
#     then
#         echo "$file is a directory"
#     elif [ -f "$file" ]
#     then
#         echo "$file is a file"
#     fi
# done


# C-stile
# for (( i=1; i <= 10; i++ ))
# do
# 	echo "number is $i"
# done


# while

# var1=5
# while [ $var1 -gt 0 ]
# do
# 	echo $var1
# 	var1=$[ $var1 - 1 ] 
# done


# var1=5
# while [ $var1 -gt 0 ]
# do
# echo $var1
# 	var1=$((var1 - 1)) # это более современный подход
# done

# var1=5
# while (( var1 > 0 ))
# do
#     echo "$var1"
#     ((var1--))
# done


# files
# IFS=$'\n'
# for entry in $(cat /etc/passwd)
# do
# 	echo "Values in $entry –"
# 	IFS=:
# 	for value in $entry
# 	do
# 		echo " $value"
# 	done
# done


IFS=:
for folder in $PATH
do
	echo "$folder:"
	for file in $folder/*
	do
		if [ -x $file ]
		then
			echo " $file"
		fi
	done
done