#!/bin/sh

for file in file1.txt tempdir file4.txt
do
    if [ -e $file ]; then
	echo -n "$file exists and is "
	if [ -f $file ]; then
	    echo "a regular file"
	elif [ -d $file ]; then
	    echo "a directory"
	else
	    echo "not regular file or directory"
	fi
    else
	echo "$file does not exist"
    fi
done    
