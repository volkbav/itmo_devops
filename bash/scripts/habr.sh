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


#If-then

if pwd
then
echo "It works"
fi