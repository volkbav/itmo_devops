#!/bin/bash

files=$(cat /etc/shells)
# echo $files
for f in $files
do
	echo $f
done
