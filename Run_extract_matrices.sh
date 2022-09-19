#!/bin/bash
#SBATCH --time=03:00:00
#SBATCH --account=def-tandrew6
#SBATCH --mem-per-cpu 30G
#SBATCH --cpus-per-task=2
#SBATCH -J extract_splice_unsplice_matrices

echo "Running extract_matrices.sh $1 $2 $3"

LOOMFILE=$1
OUTPREFIX=$2

module load python/3.9.6 hdf5/1.12.1 samtools/1.15.1;  module load scipy-stack; source $PYTHON_ENV_DIR/sc_velocity/bin/activate

## Set it to run for all droplets with > 100 umi/droplet
SCRIPT=/home/tandrew6/projects/def-tandrew6/tandrew6/External_Data/ParaAmb/extract_matrices.py

python $SCRIPT $LOOMFILE $OUTPREFIX
