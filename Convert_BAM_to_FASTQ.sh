#!/bin/bash
#SBATCH --time=4:00:00
#SBATCH --account=def-tandrew6
#SBATCH --mem 4G
#SBATCH --cpus-per-task=2
#SBATCH -J run_cellranger_count


BAM2FASTQ="/home/tandrew6/Downloaded_Software/bamtofastq_linux"

USAGE="Usage: Convert_BAM_to_FASTQ.sh bam_file output_dir -t/--threads N --cr11\n\n
	Uses 10X software to convert a BAM file back to the original fastq files.\n
	Note: output directory will be automatically created.\n\n
	\tArguments:\n
		\tbam_file = BAM file derived from running cellranger.\n
		\toutput_dir = directory for output fastqs (should not exist presently)\n
		\t-t/--threads = number of threads to run on (default 2)\n
		\t--cr11 = Convert a BAM produced by Cell Ranger 1.0-1.1\n
		\t--help = print this help message\n" 


if [ ! -f $BAM2FASTQ ] ; then
	echo "$BAM2FASTQ not available"
fi



# Read arguments
POSITIONAL_ARGS=()
THREADS=2
OLD=FALSE

echo "Running Convert_BAM_to_FASTQ.sh ${POSITIONAL_ARGS[@]}"

while [[ $# -gt 0 ]]; do
  case $1 in
    -t|--threads)
      THREADS="$2"
      shift # past argument
      shift # past value
      ;;
    --cr11)
      OLD=TRUE
      shift # past argument
      ;;
    --help)
      echo -e $USAGE
      exit 1 
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

BAM=$1
OUTDIR=$2

if [ -z $BAM ]; then
	echo -e $USAGE
	exit 1
fi
if [ -z $OUTDIR ]; then
	echo -e $USAGE
	exit 1
fi

echo "Converting $BAM to FASTQ"

if [[ $OLD == TRUE ]]; then
	$BAM2FASTQ --traceback --nthreads=$THREADS $BAM $OUTDIR --cr11
else
	$BAM2FASTQ --traceback --nthreads=$THREADS $BAM $OUTDIR
fi

