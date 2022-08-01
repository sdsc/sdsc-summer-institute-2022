split genome.fasta
split -l 2000 genome.fasta genome_
split -l 200 -t '>' genome.fasta genome_
