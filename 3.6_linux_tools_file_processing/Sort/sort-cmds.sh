sort unsorted1.txt

export LC_ALL=C
sort unsorted1.txt 
export LC_ALL=''

sort -k3 unsorted2.txt
sort -k2 unsorted2.txt
sort -k2 -n unsorted2.txt

sort -u unsorted1.txt
