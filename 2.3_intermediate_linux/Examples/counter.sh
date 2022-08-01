#!/bin/sh

# Print character, word and line count in file
# Usage: counter.sh [FILE]

# The Linux utility wc returns character (-c), word (-w)
# and line (-l) counts; the cut command splits the output
# on spaces (-d' ') and prints the first field (-f1)

c=`wc -c $1 | cut -d' ' -f1`
w=`wc -w $1 | cut -d' ' -f1`
l=`wc -l $1 | cut -d' ' -f1`

echo "$1 contains"
echo "  $c characters"
echo "  $w words"
echo "  $l lines"
