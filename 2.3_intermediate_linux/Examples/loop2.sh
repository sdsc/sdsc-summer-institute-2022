#!/bin/sh
for file in `ls -1 file*.txt`
do
    wc -l ${file}
done
