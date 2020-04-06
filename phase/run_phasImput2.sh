#!/usr/bin/env bash

home="$HOME/Git/GWAS/"
phase="${home}phase/"
sample="${home}samples/"
pop="${home}popstruct/"

function usage() {
	printf "Usage: %s [ VI|MC|IM|CC|QG ] [ options ]\n" $(basename $0)
	echo """
		IMPUTE2 IMPUTATION
		
		VI	: Run phased VCF to IMPUTE .hap + .sample
		MC	: Make chunks
		IM	: Run IMPUTE2 Imputation
		CC	: Concatenate Chunks
		QG	: Convert IMPUTE2 .gen to VCF

		Enter all to run all steps
		Enter any two to run only those two steps 

		Options:
                -v,--vcf	{str}   : Phased VCF file [Required]
                -s,--sample	{str}   : Sample file. (NB: FID and IID columns with no header) [Required]
		-c,--chunk-size	{int}	: Chunck size (e.g. 5000000) [Required]
		-n,--num-chunks	{int}	: Number of chunks to impute per chromosome [default: 1]
		-f,--from-chr	{int}	: Chrosomose to start with [defaul: 1]
		-t,--to-chr	{int}	: Chromosome to end with [default: 22]
		-g,--gp		{float}	: Minimum genotype probability at which genotypes are called
					  [default: 0.90]
                -i,--info-score	{float} : Minimum info score above which to retain SNPs [default: 0.5]
                -o,--out	{int}   : Output prefix [default: imputed]
		-h,--help		: Print this help message
	"""
}

if [ $# -lt 1 ]; then
   usage; 1>&2;
   exit 1;
fi

if [ $? != 0 ]; then
   echo "ERROR: Terminating..."; 1>&2;
   exit 1;
fi

prog=`getopt -o "hv:s:c:n:f:t:g:i:o:" --longoptions "help,vcf:,sample:,chunk-size:,num-chunks:,from-chr:,to-chr:,gp:,info-score:,out:" -- "$@"`

#vcf="${pop}Phased-pca-filtered.vcf.gz"
#sam="${sample}include_bantu-semibantu.txt"
vcf=NULL
sam=NULL
cs=5000000
nc=1
f=1
t=22
i=0.5
gp=0.90
op="imputed"

eval set -- "$prog"

while true; do
     case "$1" in
        -v|--vcf) vcf="$2";
            if [[ "$2" == -* ]]; then
               echo "ERROR: -v,--vcf must not begin with a '-' "; 1>&2;
               exit 1;
            fi;
            shift 2 
            ;;
        -s|--sample) sam="$2";
            if [[ "$2" == -* ]]; then
               echo "ERROR: -s,--sample must not begin with a '-' "; 1>&2;
               exit 1;
            fi;
            shift 2 
            ;;
        -c|--chunk-size) cs="$2";
            if [[ "$2" == -* ]]; then
               echo "ERROR: -c,--chunk_size must not begin with a '-' "; 1>&2;
               exit 1;
            fi;
            shift 2 
            ;;
        -n|--num-chunks) nc="$2";
            if [[ "$2" == -* ]]; then
               echo "ERROR: -n,--num_chunks must not begin with a '-' "; 1>&2;
               exit 1;
            fi;
            shift 2 
            ;;
        -f|--from-chr) f="$2";
            if [[ "$2" == -* ]]; then
               echo "ERROR: -f,--from_chr must not begin with a '-' "; 1>&2;
               exit 1;
            fi;
            shift 2 
            ;;
        -t|--to-chr) t="$2";
            if [[ "$2" == -* ]]; then
               echo "ERROR: -t,--to_chr must not begin with a '-' "; 1>&2;
               exit 1;
            fi;
            shift 2 
            ;;
        -g|--gp) gp="$2";
            if [[ "$2" == -* ]]; then
               echo "ERROR: -g,--gp must not begin with a '-' "; 1>&2;
               exit 1;
            fi;
            shift 2 
            ;;
        -i|--info-score) i="$2";
            if [[ "$2" == -* ]]; then
               echo "ERROR: -i,--infoscore must not begin with a '-' "; 1>&2;
               exit 1;
            fi;
            shift 2 
            ;;
        -o|--out) op="$2";
            if [[ "$2" == -* ]]; then
               echo "ERROR: -o,--out must not begin with a '-' "; 1>&2;
               exit 1;
            fi;
            shift 2 
            ;;
        -h|--help) shift; usage; 1>&2; exit 1 ;;
        --) shift; 1>&2; exit 1 ;;
        *) shift; usage; 1>&2; exit 1 ;;
     esac
done

if [[ $vcf == NULL || $sam == NULL ]]; then
   echo "ERROR: -v,--vcf AND -s,--sample must be provided!"; 1>&2;
   exit 1;
fi

   echo -e """
   		 =======================================================================
   		 IMPUTE2		IMPUTATION	kevin.esoh@students.jkuat.ac.ke
   		 -----------------------------------------------------------------------
   		 Option				Argument
		 ------				--------
   		 In VCF 			: $vcf
   		 Sample file			: $sam
   		 Chunk size			: $cs
   		 Number of chunks		: $nc
   		 From Chromosome		: $f
   		 To Chromosome			: $t
   		 Genotype Probability		: $gp
   		 Impute info score		: $i
   		 Output Prefix			: $op
   		 ======================================================================
   """
############################ Run Phasing and Imputation Pipeline ##########################
# Phasing
#./run_wphase_ref.sh

home="$HOME/Git/GWAS/"
phase="${home}phase/"
sample="${home}samples/"
pop="${home}popstruct/"


source ${phase}vcf2impute2
source ${phase}makeChunkIntervals
source ${phase}concatChunks 
source ${phase}run_impute2
source ${phase}qct2gen

# Convert Phased VCF to IMPUTE2 .haps and .sample
vcf2impute2 $vcf $sam		# include_semibantu.txt include_bantu.txt exclude_fo.txt  ${pop}Phased-pca-filtered.vcf.gz

# Make chunks
makeChunkIntervals $cs

# Run Imputation
run_impute2 $nc $f $t

# Concatenate Chunks into full chromosomes
concatChunks $i

# Convert GEN file to VCF and PLINK format using qctool and PLINK2
qct2gen $gp phasedWref.sample $op $i
