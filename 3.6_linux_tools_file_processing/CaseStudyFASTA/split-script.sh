split -l 200 -t '>' genome.fasta genome_
for file in genome_*
do
    sed 's/^sp|/>sp|/' $file > temp
    mv temp $file
done

