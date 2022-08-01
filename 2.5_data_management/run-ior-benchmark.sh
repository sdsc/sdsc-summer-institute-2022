#!/usr/bin/env bash

#SBATCH --job-name=run-ior-benchmark
#SBATCH --account=crl155
#SBATCH --reservation=SI2022DAY1
#SBATCH --partition=compute
#SBATCH --qos=normal-eot
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=1
#SBATCH --mem=243G
#SBATCH --time=00:05:00
#SBATCH --output=%x.o%j.%N

declare -xr LUSTRE_PROJECTS_DIR="/expanse/lustre/projects/${SLURM_JOB_ACCOUNT}/${USER}"
declare -xr LUSTRE_SCRATCH_DIR="/expanse/lustre/scratch/${USER}/temp_project"

declare -xr LOCAL_SCRATCH_DIR="/scratch/${USER}/job_${SLURM_JOB_ID}"

declare -xr SINGULARITY_MODULE='singularitypro/3.9'
declare -xr SINGULARITY_CONTAINER_DIR='/cm/shared/examples/sdsc/si/2022'

module purge
module load "${SINGULARITY_MODULE}"
module list
printenv

cd "${LUSTRE_SCRATCH_DIR}"

time -p singularity exec --bind /expanse "${SINGULARITY_CONTAINER_DIR}/ior.sif" \
  mpirun -n "${SLURM_NTASKS}" --mca btl self,vader --map-by l3cache \ 
    ior -a MPIIO -i 1 -t 2m -b 32m -s 1024 -C -e
