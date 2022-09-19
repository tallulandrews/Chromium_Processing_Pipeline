#!/bin/bash
#SBATCH --time=05:00:00
#SBATCH --account=def-tandrew6
#SBATCH --mem 30G

source ~/.bashrc

module load StdEnv/2020 gcc/9.3.0; module load sra-toolkit/3.0.0

# Use Pattern Matching to extract all lines corresponding to 1 sample.
arr_SRA=($(awk '/Donor2/ {print $1}' MacParland_SC_SN_Spatial_SraAccList.txt))
arr_PREFIX=($(awk '/Donor2/ {print $2}' MacParland_SC_SN_Spatial_SraAccList.txt))

FASTQDIR="Donor2_fastq"
mkdir -p $FASTQDIR

length=${#arr_SRA[@]}
for (( j=0; j<${length}; j++ ));
do
    $SRA=$arr_SRA[j]
    $PREFIX=$arr_PREFIX[j]
    fastq-dump --split-files --origfmt --gzip --outdir $FASTQDIR $SRA_repo
    cd $FASTQDIR
    pwd | echo
    mv ${SRA}_1.fastq.gz  ${PREFIX}_I1_001.fastq.gz
    mv ${SRA}_2.fastq.gz  ${PREFIX}_R1_001.fastq.gz
    mv ${SRA}_3.fastq.gz  ${PREFIX}_R2_001.fastq.gz
    cd ..
    pwd | echo
done

# Convert BAM to FASTQ
# Download FASTQ from SRA
#fastq-dump --split-files --origfmt --gzip --outdir $FASTQDIR $SRA_repo
# Convert SRA into FastQs?

# Manually rename files?
# https://kb.10xgenomics.com/hc/en-us/articles/115003802691-How-do-I-prepare-Sequence-Read-Archive-SRA-data-from-NCBI-for-Cell-Ranger-


#mv SRR16227573_1.fastq.gz  C70_Caudate_S4_L001_I1_001.fastq.gz
#mv SRR16227573_2.fastq.gz  C70_Caudate_S4_L001_R1_001.fastq.gz
#mv SRR16227573_3.fastq.gz  C70_Caudate_S4_L001_R2_001.fastq.gz
