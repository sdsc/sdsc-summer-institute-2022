export PATH="/cm/shared/apps/sdsc/galyleo:${PATH}"
SIMG='/expanse/lustre/projects/sds166/zonca/dask-numba-si22.sif'
# Summer institute account
ACCOUNT=crl155
# Use current folder
NOTEBOOK_FOLDER=$(pwd -P)
# Create link
cd 1_dask_tutorial
rm -f data
ln -s /expanse/lustre/projects/sds166/zonca/dask_tutorial_data data
cd ../
# Use the user home
# NOTEBOOK_FOLDER=${HOME}
RESERVATION=SI2022DAY3
galyleo.sh launch --account $ACCOUNT --reservation ${RESERVATION} --partition 'compute' --cpus-per-task 128 --time-limit 02:45:00 --jupyter 'lab' --notebook-dir "${NOTEBOOK_FOLDER}" --env-modules 'singularitypro' --bind '/expanse,/scratch' --sif "${SIMG}"
