# Description

This is a processing pipeline for 10X Chromium single-cell RNAseq data with cellranger and RNA velocity to obtain spliced and unspliced count matrices. It include additional scripts for obtaining raw FastQ files from the SRA. 

## Environment / Installation

This pipeline is designed for the ComputeCanada / Canadian Digital Alliance Infrastructure, and assumes you have installed cellranger as a module like so:
[download cellranger](https://support.10xgenomics.com/single-cell-gene-expression/software/downloads/latest)
```
eb CellRanger-7.0.1.eb --sourcepath=<path to the location of cellranger-7.0.1.tar.gz>
```
This will create the module cellranger/7.0.1 which will be loaded in Run_Cellranger.sh

And installed the velocyto python package in its own python environment called "sc_velocity", this is necessary for the Run_Velocyto_10x.sh and Run_extract_matries.sh script.

For accessing data from the SRA you may need to download:
[bamtofastq_linux](https://support.10xgenomics.com/docs/bamtofastq)

Other dependencies already installed on ComputeCanada:
sra-toolkit
samtools
python
hdf5

Key variables that will require editing by the user to run this pipeline are listed at the top of each script (e.g. location where you downloaded this package, loading required modules, and job-submission information).

# Order of Steps:

1. Obtain FastQ files -> "Convert_BAM_to_FASTQ.sh" and "Get_FASTQ_from_SRA.sh" are provided to facilitate obtaining these files for data stored in GEO and the SRA.
2. Run Cellranger -> Run_CellRanger.sh
3. Pre-sort the bam file and refilter barcodes to enable detection of small cells using DropletQC and/or EmptyDrops. -> Run_velocyto_refilter_cells.sh
4. Run velocyto -> Run_Velocyto_10x.sh
5. Extract matrices from loom files for reading into R -> Run_extract_matrices.sh

## 1) Obtain FastQ files
Either direct from a sequencing facility, or from the SRA archive using Get_FASTQ_from_SRA.sh, or from a bam file using Convert_BAM_to_FASTQ.sh. R1 should include droplet barcodes and UMIs, R2 should include sequence matching the transcript. Note that reformatting of file names may be necessary for cellranger to correctly recognize them. See: Example_SraAccList_for_Getting_FASTQs.txt for an example of correct name formatting.

## 2) Run Cellranger
We assume cellranger is installed as a module, but the script can be easily adapted by adding a variable with the full path to your cellranger executable for other installations. Currently the genome used is hard-coded into the script, but could easily be turned into an argument like the sampleID and number of expected cells. Cellranger is run with quantification of intronic reads turned on as this is the current recommendation from 10X genomics.

## 3) Prepare for Velocyto
Velocyto often builds itself using an old version of samtools when installed on a system with multiple version of samtools available, leading to errors when sorting the bamfile by droplet-barcode. Thus we pre-sort the bamfile with a separate script to ensure the correct version of samtools is used.

In addition, running velocyto in 10x mode automatically uses the cellranger filtered droplets. To make the output of velocyto compatible with better cell-identifying algorithms such as EmptyDrops we alter the "barcodes.tzv.gz" file in the filtered matrix folder to include all droplets with >100 detected UMIs. This threshold can be changed as an argument.

## 4) Run Velocyto
To support the use of a pre-sorted bamfile, we run Velocyto in 10x mode using default parameters.

## 5) Extract Matrices
Support for .loom files in R is relatively poor, furthermore velocyto looms do not use sparse matrix representations making them very memory inefficient in R. Thus, we use scipy in python to convert the velocyto loom files into sparse matrix (.mtx) representation that can be read into R using the Matrix package. 

This is Version 0.1.0 of the pipeline that has been tested on the graham system.
