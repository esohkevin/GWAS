#!/usr/bin/env bash

function usage() {
	printf "Usage: %s [ options ]\n" $(basename $0);
	echo -e """
		IMPUTE2 IMPUTATION

		Options:
                -v,--vcf	{str}   : Phased VCF file [Required]
                -s,--sample	{str}   : Sample file. (NB: FID and IID columns with no header) [Required]
		-c,--chunksize	{int}	: Chunck size (e.g. 5000000) [Required]
		-n,--nchunks	{int}	: Number of chunks to impute per chromosome [default: 1]
		-f,--fchr	{int}	: Chrosomose to start with [defaul: 1]
		-t,--tchr	{int}	: Chromosome to end with [default: 22]
		-g,--gp		{float}	: Minimum genotype probability at which genotypes are called
					  [default: 0.90]
                -i,--info	{int}   : Minimum info score above which to retain SNPs [default: 0.5]
                -o,--outprfx	{int}   : Output prefix [default: imputed]
		-h,--help		: Print this help message
	"""
}

home="$HOME/Git/GWAS/"
phase="${home}phase/"
sam="${home}samples/"
pop="${home}popstruct/"

if [ $# -lt 1 ]; then
   usage;
   1>&2;
   exit 1;
fi

if [ $? != 0 ]; then
   echo "ERROR: Terminating...";
   1>&2;
   exit 1;
fi

prog=`getopt -o "hv:s:c:n:f:t:g:i:o:" --long "help,vcf:,sample:,chunksize:,nchunks:,fchr:,tchr:,gp:,info:,outprfx:" -- "$@"`

vcf=NULL
sam=NULL
cs=5000000
nc=1
f=1
t=22
gp=0.90
i=0.5
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
        -c|--chunksize) cs="$2";
            if [[ "$2" == -* ]]; then
               echo "ERROR: -c,--chunk_size must not begin with a '-' "; 1>&2;
               exit 1;
            fi;
            shift 2 
            ;;
        -n|--nchunks) nc="$2";
            if [[ "$2" == -* ]]; then
               echo "ERROR: -n,--num_chunks must not begin with a '-' "; 1>&2;
               exit 1;
            fi;
            shift 2 
            ;;
        -f|--fchr) f="$2";
            if [[ "$2" == -* ]]; then
               echo "ERROR: -f,--from_chr must not begin with a '-' "; 1>&2;
               exit 1;
            fi;
            shift 2 
            ;;
        -t|--tchr) t="$2";
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
        -i|--info) i="$2";
            if [[ "$2" == -* ]]; then
               echo "ERROR: -i,--info_score must not begin with a '-' "; 1>&2;
               exit 1;
            fi;
            shift 2 
            ;;
        -o|--outprfx) op="$2";
            if [[ "$2" == -* ]]; then
               echo "ERROR: -o,--outprfx must not begin with a '-' "; 1>&2;
               exit 1;
            fi;
            shift 2 
            ;;
        -h|--help) shift; usage; 1>&2; exit 1 ;;
        --) shift; 1>&2; exit 1 ;;
        *) shift; usage; 1>&2; exit 1 ;;
     esac
     continue
done

if [[ "${vcf}" == NULL ]] || [[ "${sam}" == NULL ]]; then
   echo "ERROR: -v,--vcf AND -s,--sample must be provided!"
   1>&2;
   exit 1;
fi

if [[ $? != 0 ]]; then
    echo "An ERROR occurred! Terminating..."
    sleep 1;
    1>&2;
    exit 1;
else
   echo -e """=============================================================
   IMPUTE2		IMPUTATION	kevin.esoh@students.jkuat.ac.ke
   
   Option			Argument
   In VCF 			: $v
   Sample file			: $s
   Chunk size			: $cs
   Number of chunks		: $nc
   From Chromosome		: $f
   To Chromosome		: $t
   Genotype Probability		: $gp
   Impute info score		: $i
   Output Prefix		: $op
   ============================================================="""
   
   ############################ Run Phasing and Imputation Pipeline ##########################
   # Phasing
   #./run_wphase_ref.sh
   
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
fi
