#!/bin/sh
# Script to execute head, tail and wc
echo "-- First two lines of file1.txt"
head -2 file1.txt
echo
echo "-- Last two lines of file1.txt"
tail -2 file1.txt
echo
echo "-- Number of lines in file1.txt"
wc -l file1.txt

