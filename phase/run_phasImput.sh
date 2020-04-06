#!/usr/bin/env bash

phase_path="${HOME}phase/"
sample_path="${HOME}samples/"
analysis="${HOME}analysis/"
assocResults="${HOME}assoc_results/"
pop="${HOME}popstruct/"

function usage() {
	printf "Usage: %s [ VI|MC|IM|CC|QG ] [ options ]\n" $(basename $0);
	echo -e """
		IMPUTE2 IMPUTATION

		Enter 'VI' OR 'MC' OR 'IM' OR all to run either vcf2impute OR make-chunks OR impute2 or all steps.
		Enter any two to run only those two steps 

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

if [ $# -lt 1 ]; then
   usage; 1>&2;
   exit 1;
fi

if [ $? != 0 ]; then
   echo "ERROR: Terminating..."; 1>&2;
   exit 1;
fi

prog=`getopt -o "hv:s:c:n:f:t:g:i:o:" --longoptions "help,vcf:,sample:,chunksize:,nchunks:,fchr:,tchr:,gp:,info:,outprfx:" -- "$@"`

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

if [[ $vcf == NULL || $sam == NULL ]]; then
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
   #--- Define functions

    #--- Convert phased haplotypes in vcf format to IMPUTE2 .haps + .sample format
    function vcf2impute() {
          for chr in {1..22}; do
            if [[ -f "${phase_path}""chr${chr}-phased_wref.vcf.gz" ]]; then
               if [[ ! -f "chr${chr}-phased_wref.haps" ]]; then
                  plink2 \
      	            --vcf ${vcf} \
      	            --export haps \
      	            --chr ${chr} \
      	            --covar ${sample_path}cor.pca.txt \
      	            --covar-name C1-C10 \
      	            --keep-allele-order \
                    --keep $sam \
     	            --pheno ${analysis}qc-camgwas-updated.fam \
     	            --pheno-col-nums 6 \
     	            --update-sex ${analysis}qc-camgwas-updated.fam col-num=5 \
     	            --double-id \
     	            --out chr"${chr}"-phased_wref
               else
                  echo "chr"${chr}"-phased_wref.haps already exists!"
               fi
            else
               echo "chr"${chr}"-phased_wref.vcf.gz was not found!"
            fi
          done
          mv chr1-phased_wref.sample phasedWref.sample
          rm chr*.sample
    }

    function makeChunkIntervals() {
          chrSize="252000000 246000000 202000000 194000000 185000000 174000000 163000000 149000000 142000000 136000000 139000000 137000000 118000000 111000000 106000000 92200000 85200000 82200000 60200000 66200000 48200000 52200000"
          if [[ $cs -lt 1000000 || $cs -gt 10000000 ]]; then
             echo -e "\nChunk size must be within the range 1,000,000 - 10,000,000( between 1million and 10million)!\n"
          else
             for size in ${chrSize}; do
                for interval in $(seq 1 $cs $size); do
                   echo $(($interval)) >> chr"${size}".tmp1;
                   echo $(($interval-1)) >> chr"${size}".tmp2;
                done;
                   sed '1d' chr"${size}".tmp2 > chr"${size}".tmp3
                   paste chr"${size}".tmp1 chr"${size}".tmp3 > chr"${size}".tmp4
                   sed 's/\t/=/g' chr"${size}".tmp4 > chr"${size}".tmp5
                   head -n -1 chr"${size}".tmp5 > chr"${size}".txt
                rm *.tmp*
             done;
             mv chr252000000.txt  chr1intervals.txt
             mv chr246000000.txt  chr2intervals.txt
             mv chr202000000.txt  chr3intervals.txt
             mv chr194000000.txt  chr4intervals.txt
             mv chr185000000.txt  chr5intervals.txt
             mv chr174000000.txt  chr6intervals.txt
             mv chr163000000.txt  chr7intervals.txt
             mv chr149000000.txt  chr8intervals.txt
             mv chr142000000.txt  chr9intervals.txt
             mv chr136000000.txt  chr10intervals.txt
             mv chr139000000.txt  chr11intervals.txt
             mv chr137000000.txt  chr12intervals.txt
             mv chr118000000.txt  chr13intervals.txt
             mv chr111000000.txt  chr14intervals.txt
             mv chr106000000.txt  chr15intervals.txt
             mv chr92200000.txt  chr16intervals.txt
             mv chr85200000.txt  chr17intervals.txt
             mv chr82200000.txt  chr18intervals.txt
             mv chr60200000.txt  chr19intervals.txt
             mv chr66200000.txt  chr20intervals.txt
             mv chr48200000.txt  chr21intervals.txt
             mv chr52200000.txt  chr22intervals.txt
          fi
    }

    #--- IMPUTE2
    function imput2() {
          nj="$nc"
          nl="$f"
          nh="$t"
          for chr in $(seq $nl $nh); do
            if [[ -f "chr${chr}-phased_wref.haps" ]]; then
               if [[ ! -f "chr${chr}intervals.txt" ]]; then
                  echo -e "\nFound no chunk interval file for chr${chr}! Please run 'makeChunkIntervals'"
               else 
                  if [[ -f "chr${chr}_chunks.txt" ]]; then
                     rm chr${chr}_chunks.txt
                  fi
                  for interval in `cat chr${chr}intervals.txt`; do
                    if [[ ! -f "chr${chr}_${interval/=*/_imputed.gen.gz}" && ! -f "${imputed_path}chr${chr}_${interval/=*/_imputed.gen.gz}" ]]; then
       	           echo -e "-use_prephased_g -known_haps_g chr"${chr}"-phased_wref.haps -m "$ref_path"genetic_map_chr"${chr}"_combined_b37.txt -h "$ref_path"1000GP_Phase3_chr"${chr}".hap.gz -l "$ref_path"1000GP_Phase3_chr"${chr}".legend.gz  -int "${interval}" -Ne 20000 -os 0 1 2 3 -buffer 1000 -filt_rules_l 'TYPE==\"Biallelic_INDEL\"' 'TYPE==\"Biallelic_DEL\"' 'TYPE==\"Multiallelic_SNP\"' 'TYPE==\"Multiallelic_INDEL\"' 'TYPE==\"Multiallelic_CNV\"' 'TYPE==\"Biallelic_INV\"' 'TYPE==\"Biallelic_INS:MT\"' 'TYPE==\"Biallelic_INS:ME:SVA\"' 'TYPE==\"Biallelic_INS:ME:LINE1\"' 'TYPE==\"Biallelic_INS:ME:ALU\"' 'TYPE==\"Biallelic_DUP\"' 'AFR==0' -o_gz -o chr"${chr}"_"${interval/=*/_imputed.gen}"" >> chr${chr}_imput_chunks.txt
                    else
                       echo "chr"${chr}"_"${interval/=*/_imputed.gen}" already exists! Its command line has not been included in chr${chr}_chunks.txt file! "
                    fi
                  done
                  sed 's/1=/1 /g' chr${chr}_imput_chunks.txt > chr${chr}_chunks.txt; 		# Primary aim is to create this file for all chrs to use for parallele jod execution
                  rm chr${chr}_imput_chunks.txt
       	      cat chr${chr}_chunks.txt | xargs -P$nj -n37 impute_v2.3.2 &			# Run IMPUTE2 with the commands in the files previously created
               fi
            else
               echo "chr"${chr}"-phased_wref.haps could not be found!"     
            fi
          done
            if [[ -f "*.warnings" ]]; then
               rm *.warnings
            fi
       else
          	echo """
          	Usage: ./run_impute2.sh <NJ> <NL> <NH>
          	
          		NJ: Number of jobs to run per chromosome
       		NL: Lower chrom number. CHROM to start with
                       NH: Higher chrom number. CHROM to end with
            """
    }

    function concatChunks() {
          for chr in {1..22}; do
             for chunk in $(ls chr${chr}_*_imputed.gen.gz); do zcat ${chunk}; done | awk '($4=="A" || $4=="T" || $4=="G" || $4=="C") && ($5=="A" || $5=="T" || $5=="G" || $5=="C")' | bgzip -c > chr${chr}_imputed.gen.gz
             for chunk in $(ls chr${chr}_*_imputed.gen_info); do cat ${chunk}; done | awk '($4=="A" || $4=="T" || $4=="G" || $4=="C") && ($5=="A" || $5=="T" || $5=="G" || $5=="C")' > chr${chr}_imputed.gen.info
             awk -v i="$info" '$7>=i {print $2}' chr${chr}_imputed.gen.info > chr${chr}_imputed.gen.include_r2_${info}
          done
    }

    function qct2gen() {
          hc=$gp
          sf="phasedWref.sample"
          if [[ -f merge.list ]]; then
              rm merge.list
          fi
          for chr in {1..22}; do
            qctool_v2.0.1 \
             -g chr${chr}_imputed.gen.gz \
             -s $sf \
             -og chr${chr}_imputed.vcf \
             -os chr${chr}_imputed.sample \
             -precision 1 \
             -threshold $hc \
             -assume-chromosome $chr \
             -threads 60 \
             -incl-rsids chr${chr}_imputed.gen.include_r2_${info} \
             -ofiletype vcf \
             -sort
            bgzip -f -@ 30 chr${chr}_imputed.vcf
            bcftools index --threads 50 -f -t chr${chr}_imputed.vcf.gz
          done
          bcftools concat --threads 30 -D -a -Oz -o ${op}.r2_${info}.vcf.gz chr{1..22}_imputed.vcf.gz
       fi
    }

    #--- Run commands
    while true; do
      case "$1" in
         VI) 
	     if [[ $vcf == NULL || $sam == NULL ]]; then 
		 echo "ERROR: -v,--vcf AND -s,--sample must be provided!";
		 1>&2;
		 exit 1;
	     else
		 vcf2impute $vcf $sam; shift
	     fi 
	 ;;
         MC) makeChunkIntervals $cs; shift ;;
	 IM) imput2 $n $f $t; shift ;;
         CC) concatChunks $info; shift ;;
	 QG) qct2gen $gp $sam $op $info; shift ;;
	 *) echo -e "\nNo command passed! Please enter at least one coomand: [ VI|MC|IM|CC|QG ]\nOr type [-h|--help] for usage\n"; shift; 1>&2; exit 1 ;;
      esac
      continue
    done
fi
