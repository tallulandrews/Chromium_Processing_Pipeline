#!/bin/bash
#SBATCH --time=24:00:00
#SBATCH --account=def-tandrew6
#SBATCH --mem 164G
#SBATCH --cpus-per-task=1
#SBATCH -J run_velocyto

# Note: normally 64G of RAM is sufficient

source ~/.bashrc

echo "Running Run_Velocyto_10x.sh $1 $2 $3"

CELLRANGER_DIR=$1
CELLRANGER_GENOME="/scratch/tandrew6/Genomes/Human/refdata-gex-GRCh38-2020-A/"
CELLRANGER_GTF="/scratch/tandrew6/Genomes/Human/refdata-gex-GRCh38-2020-A/genes/genes.gtf"
THREADS=1
MEMORY_GB=60

# Load velocyto - if using Conda or other environment manager change this block to load velocyto
module load python/3.9.6; module load scipy-stack; source $PYTHON_ENV_DIR/sc_velocity/bin/activate
module load samtools/1.15.1; module load hdf5/1.12.1

# Run velocyto
echo "velocyto run10x --samtools-threads 1 --samtools-memory $((1000*$MEMORY_GB)) $CELLRANGER_DIR $CELLRANGER_GTF"
velocyto run10x --samtools-threads $THREADS --samtools-memory $((1000*$MEMORY_GB)) $CELLRANGER_DIR $CELLRANGER_GTF

