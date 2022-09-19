# Description

This is a processing pipeline for 10X Chromium single-cell RNAseq data with cellranger and RNA velocity to obtain spliced and unspliced count matrices. It include additional scripts for obtaining raw FastQ files from the SRA. 

## Environment / Installation

This pipeline is designed for the ComputeCanada / Canadian Digital Alliance Infrastructure, and assumes you have installed cellranger as a module like so:


And installed the velocyto python package in its own python environment like so:

Key variables that will require editing by the user to run this pipeline are listed at the top of each script (e.g. location where you downloaded this package, loading required modules, and job-submission information).

# Order of Steps:

1. Obtain FastQ files -> "Convert_BAM_to_FASTQ.sh" and "Get_FASTQ_from_SRA.sh" are provided to facilitate obtaining these files for data stored in GEO and the SRA.
2. Run Cellranger -> Run_CellRanger.sh
3. Pre-sort the bam file and refilter barcodes to enable detection of small cells using DropletQC and/or EmptyDrops. -> Run_velocyto_refilter_cells.sh
4. Run velocyto -> Run_Velocyto_10x.sh
5. Extract matrices from loom files for reading into R -> Run_extract_matrices.sh

## 1) Obtain FastQ files

## 2) Run Cellranger

## 3) Prepare for Velocyto

## 4) Run Velocyto

## 5) Extract Matrices

This is Version 0.1.0 of the pipeline that has been tested on the graham system.
