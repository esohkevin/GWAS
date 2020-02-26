#!/bin/bash

alder="../alder/"
data="/mnt/lustre/groups/CBBI1243/KEVIN/git/data/"
invcf="${data}qc1kgp_merge.vcf.gz"

if [[ $# == 3 ]]; then

   #for pop in $(cat pop.list); do shuf -n50 ../../samples/${pop}.ids; done > thinned.txt

   pop="${1/.*/}"
   maf="$2"
   outdir="$3/"

   #----- Prepare world pops for pca and fst
   plink \
       --vcf ${invcf} \
       --extract msl.rsids \
       --indep-pairwise 50 10 0.1 \
       --keep-allele-order \
       --out pruned

   #----- Prepare world pops for pca and fst
   plink \
       --vcf ${invcf} \
       --extract msl.rsids \
       --make-bed \
       --indiv-sort f camWorld3577.eth \
       --double-id \
       --maf ${maf} \
       --threads 30 \
       --keep ${pop}.ids \
       --keep-allele-order \
       --autosome \
       --out temp-${pop}
   
   plink \
       --bfile temp-${pop} \
       --recode \
       --keep-allele-order \
       --autosome \
       --threads 30 \
       --out ${outdir}${pop}

   rm ${outdir}/*.nosex *.nosex pruned.* temp*
   else 
       echo """
  	Usage:./prepWorldpops.sh <pop.ids> <maf> <out-dir>

     pop.ids: Individual ID list for pop to analyze
   	 maf: MAF
     out-dir: Output directory e.g. world/CONVERTF/
   """
fi
