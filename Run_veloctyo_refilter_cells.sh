#!/bin/bash
#SBATCH --time=05:00:00
#SBATCH --account=def-tandrew6
#SBATCH --mem 64G
#SBATCH --cpus-per-task=1
#SBATCH -J fix_up_for_velocyto

echo "Running Run_veloctyo_refilter_cells.sh $1"

CELLRANGER_OUTDIR=$1

## Presort the BAM file
module load samtools/1.15.1

samtools sort -t CB -O BAM -m 30G --threads 1 -o $CELLRANGER_OUTDIR/cellsorted_possorted_genome_bam.bam $CELLRANGER_OUTDIR/possorted_genome_bam.bam 

## Set it to run for all droplets with > 100 umi/droplet
SCRIPT=/home/tandrew6/projects/def-tandrew6/tandrew6/External_Data/ParaAmb/velocyto_refilter_cells.R

module load gcc/9.3.0 r/4.1.2 geos jags hdf5/1.12.1

mv $CELLRANGER_OUTDIR/filtered_feature_bc_matrix/barcodes.tsv.gz $CELLRANGER_OUTDIR/filtered_feature_bc_matrix/orig_barcodes.tsv.gz

Rscript $SCRIPT $CELLRANGER_OUTDIR 200

mv $CELLRANGER_OUTDIR/filtered_feature_bc_matrix/velocyto_barcodes.tsv $CELLRANGER_OUTDIR/filtered_feature_bc_matrix/barcodes.tsv

gzip $CELLRANGER_OUTDIR/filtered_feature_bc_matrix/barcodes.tsv
