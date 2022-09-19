#!/bin/bash
#SBATCH --time=05:00:00
#SBATCH --account=def-tandrew6
#SBATCH --mem 30G

source ~/.bashrc

module load StdEnv/2020 gcc/9.3.0; module load sra-toolkit/3.0.0

# This script assumes you have created a file with the following columns for 
# the samples you wish to process:
# SRA_ID Sample_file_ID

# Use Pattern Matching to extract all lines corresponding to 1 sample. Here Donor2 is a 
# key phrase in the Sample_file_ID to identify all files from the same sample.
arr_SRA=($(awk '/Donor2/ {print $1}' MacParland_SC_SN_Spatial_SraAccList.txt))
arr_PREFIX=($(awk '/Donor2/ {print $2}' MacParland_SC_SN_Spatial_SraAccList.txt))

FASTQDIR="Donor2_fastq"
mkdir -p $FASTQDIR

# Loop over all SRA ids for this sample
length=${#arr_SRA[@]}
for (( j=0; j<${length}; j++ ));
do
    $SRA=$arr_SRA[j]
    $PREFIX=$arr_PREFIX[j]
    # Download the files -> fastq-dump can be found inside sra-toolkit
    fastq-dump --split-files --origfmt --gzip --outdir $FASTQDIR $SRA_repo
    cd $FASTQDIR
    pwd | echo
    # NOTE: You should manually check that this naming convention is correct for your
    # particular dataset of interest, as SRA is not enforcing specific standards. Also,
    # only R1 and R2 are required to run cellranger, thus your dataset may only have two
    # files.
    mv ${SRA}_1.fastq.gz  ${PREFIX}_I1_001.fastq.gz
    mv ${SRA}_2.fastq.gz  ${PREFIX}_R1_001.fastq.gz
    mv ${SRA}_3.fastq.gz  ${PREFIX}_R2_001.fastq.gz
    cd ..
    pwd | echo
done

