#!/bin/sh
for x in file1.txt file2.txt file3.txt
do
    wc -l ${x}
done
