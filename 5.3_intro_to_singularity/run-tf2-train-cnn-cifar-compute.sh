#!/usr/bin/env bash

#SBATCH --job-name=tf2-train-cnn-cifar-compute
#SBATCH --account=crl155
#SBATCH --reservation=SI2022DAY4
#SBATCH --partition=compute
#SBATCH --qos=normal-eot
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=128
#SBATCH --cpus-per-task=1
#SBATCH --mem=243G
#SBATCH --time=00:10:00
#SBATCH --output=%x.o%j.%N

declare -xr LUSTRE_PROJECT_DIR="/expanse/lustre/projects/${SLURM_ACCOUNT}/${USER}"
declare -xr LUSTRE_SCRATCH_DIR="/expanse/lustre/scratch/${USER}/temp_project"

declare -xr LOCAL_SCRATCH_DIR="/scratch/${USER}/job_${SLURM_JOB_ID}"

declare -xr SINGULARITY_MODULE='singularitypro/3.9'
declare -xr SINGULARITY_CONTAINER_DIR='/cm/shared/apps/containers/singularity'

module purge
module load "${SINGULARITY_MODULE}"
module list
printenv

time -p singularity exec "${SINGULARITY_CONTAINER_DIR}/tensorflow/tensorflow-latest.sif" python3 -u tf2-train-cnn-cifar.py --classes 10 --precision fp32 --epochs 42 --batch_size 256
