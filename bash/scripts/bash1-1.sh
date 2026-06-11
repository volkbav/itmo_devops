#!/bin/bash

files=$(cat /etc/shells)
# echo $files
for f in $files
do
	link=$(ls -l $f)
	echo $link
done
