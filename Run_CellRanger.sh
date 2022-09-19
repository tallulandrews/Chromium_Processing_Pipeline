#!/bin/bash
#SBATCH --time=24:00:00
#SBATCH --account=def-tandrew6
#SBATCH --mem 64G
#SBATCH --cpus-per-task=16
#SBATCH -J run_cellranger_count

source ~/.bashrc

echo "Running Run_CellRanger.sh $1 $2 $3"

ID=$1
FASTQDIR=$2
N_cells=$3
CELLRANGER_DIR=$ID"_cellranger"
N_THREADS=16
MAX_MEM=60 # in Gb
# If you frequently work with different species you may want to make these additional arguments
CELLRANGER_GENOME="/scratch/tandrew6/Genomes/Human/refdata-gex-GRCh38-2020-A/"

# Error Catching #
USAGE="Usage: Run_CellRanger.sh output_id fastQ_dir N_cells\n\n
        Runs cellranger(v7.0.1) to map reads to the human genome, followed by velocyto to quantify spliced and unspliced reads as a single job on the cluster.\n
        Note: output directory will be automatically created.\n\n
        \tArguments:\n
                \toutput_id = Prefix for cellranger and velocyto output directories.\n
                \tfastq_dir = directory of correctly formatted fastqs\n
                \tN_cells = expected number of cells.\n"

if [ -z $ID ]; then
	echo -e $USAGE
	exit 1
fi

if [ -z $FASTQDIR ]; then
	echo -e $USAGE
	exit 1
fi

if [ -z $N_cells ]; then
	echo -e $USAGE
	exit 1
fi

# Check Cellranger Genome
MISSING_CELLRANGER="Please re-download the cellranger genome in: /scratch/tandrew6/Genomes/Human/\n
                Using the following commands:\n
                cd /scratch/tandrew6/Genomes/Human/\n
                wget https://cf.10xgenomics.com/supp/cell-exp/refdata-gex-GRCh38-2020-A.tar.gz\n
                tar -xcvf refdata-gex-GRCh38-2020-A.tar.gz\n"

if [ -d "$CELLRANGER_GENOME" ]; then
	if [ ! "$(ls -A $CELLRANGER_GENOME)" ]; then
    		echo -e $MISSING_CELLRANGER; exit 1
	fi
else
	echo -e $MISSING_CELLRANGER; exit 1
fi

echo "input: $FASTQDIR"
echo "cells: $N_cells"
echo "output: $CELLRANGER_DIR"

# Load cellranger
module load samtools/1.15.1
module load cellranger/7.0.1; source $EBROOTCELLRANGER/sourceme.bash

# check cellranger
command -v cellranger >/dev/null 2>&1 || { echo >&2 -e "I require cellranger version 7.0.1 installed as a module\n
		Use: eb CellRanger-7.0.1.eb --sourcepath=<path to the location of cellranger-7.0.1.tar.gz> to set it up.\n
		cellranger can be downloaded using wget here: https://support.10xgenomics.com/single-cell-gene-expression/software/downloads/latest\n"; exit 1; }

# Run cellranger
cellranger count --id $CELLRANGER_DIR --fastqs $FASTQDIR --transcriptome $CELLRANGER_GENOME --localcores=$N_THREADS --jobmode=local --localmem=$MAX_MEM --include-introns true --expect-cells $N_cells 


