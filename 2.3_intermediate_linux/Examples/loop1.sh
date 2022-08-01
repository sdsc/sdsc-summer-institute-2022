#!/bin/sh
for filename in file*.txt
do
    wc -l ${filename}
done
