#!/bin/sh

if [ $1 -lt $2 ]; then
    echo "$1 is less than $2"
fi

if [ $1 -le $2 ]; then
    echo "$1 is less than or equal to $2"
fi

if [ $1 -gt $2 ]; then
    echo "$1 is greater than $2"
fi

if [ $1 -ge $2 ]; then
    echo "$1 is greater than or equal to $2"
fi

if [ $1 -eq $2 ]; then
    echo "$1 is equal to $2"
fi
