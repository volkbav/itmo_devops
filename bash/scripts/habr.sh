#!/bin/bash
# code takes from https://habr.com/ru/companies/ruvds/articles/325522/


# our comment is here
# echo "The current directory is:"
# pwd
# echo "The user logged in is:"
# whoami


# display user home
# echo "Home for the current user is: $HOME"

# echo "I have \$1 in my pocket"


# Users variables
# grade=5
# person="Adam"
# echo "$person is a good boy, he is in grade $grade"


# command

# old version
# mydir=`pwd`
# echo "old version $mydir"

# # useable
# mydir=$(pwd)

# echo "new version $mydir"


# math operations
# var1=$(( 5 + 5 ))
# echo $var1
# var2=$(( $var1 * 2 ))
# echo $var2


# if-then-else

# if pwd
# then
# echo "It works"
# fi

# user=alex
# if grep $user /etc/passwd
# then
# echo "The user $user Exists"
# fi

# user=new_user
# if grep $user /etc/passwd
# then
# echo "The user $user Exists"
# else
# echo "The user $user doesn't exist"
# fi


# elif

# user=anotherUser
# first_user=$USER
# if grep $user /etc/passwd
# then
# echo "The user $user Exists"
# elif ls /home/$first_user
# then
# echo "The user doesn’t exist but anyway there is a directory under /home/$first_user"
# fi

# Сравнение чисел

# val1=6
# if [ $val1 -gt 5 ]
# then
# echo "The test value $val1 is greater than 5"
# else
# echo "The test value $val1 is not greater than 5"
# fi


# сравнение строк

# user="likegeeks"
# if [ $user = $USER ]
# then
# echo "The user $user  is the current logged in user"
# else
# echo "Ooops"
# fi

# val1="text"
# val2="another text"
# if [ "$val1" \> "$val2" ] # тут была ошибка (не было "")
# then
# echo "$val1 is greater than $val2"
# else
# echo "$val1 is less than $val2"
# fi

val1=Likegeeks
val2=likegeeks
if [ "$val1" \> "$val2" ]
then
echo "$val1 is greater than $val2"
else
echo "$val1 is less than $val2"
fi