#!/usr/bin/env bash

#SBATCH --job-name=compute-pi-stats
#SBATCH --account=crl155
#SBATCH --reservation=SI2022DAY2
#SBATCH --partition=shared
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=00:30:00
#SBATCH --output=%x.o%j.%N

declare -xir DEPENDENT_SLURM_ARRAY_JOB_ID="$(echo ${SLURM_JOB_DEPENDENCY} | grep -o '[[:digit:]]*')"

module reset
module load gcc
module load gnuplot

echo "$(cat estimate-pi.o${DEPENDENT_SLURM_ARRAY_JOB_ID}.*)" | \
  gnuplot -e 'stats "-"; print STATS_mean, STATS_stddev'
