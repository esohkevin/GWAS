#!/bin/bash

analysis="../../analysis/"
samples="../../samples/"
kgp="../../1000G/"
phase="../../phase/"
imput="../../assoc_results/"

if [[ $# == 2 ]]; then

#   for pop in $(cat pop.list); do shuf -n50 ../../samples/${pop}.ids; done > wthinned.txt

   wmaf="$1"
   amaf="$2"

   #----- Prepare world pops for pca and fst
   plink \
       --vcf ${phase}qc1kgp_merge.vcf.gz \
       --extract msl.rsids \
       --indep-pairwise 500kb 50 0.1 \
       --keep-allele-order \
       --out pruned

   #----- Prepare world pops for pca and fst
   plink \
       --vcf ${phase}qc1kgp_merge.vcf.gz \
       --extract msl.rsids \
       --recode \
       --double-id \
       --maf ${wmaf} \
       --threads 30 \
       --keep-allele-order \
       --autosome \
       --out CONVERTF/world
   
   #for pop in $(cat afr-pop.list | tr '[:upper:]' '[:lower:]'); do shuf -n50 ../../samples/${pop}.ids; done > athinned.txt
   
   #----- Prepare world pops for pca and fst
   plink \
       --vcf ${phase}qc1kgp_merge.vcf.gz \
       --extract msl.rsids \
       --indep-pairwise 500kb 50 0.1 \
       --keep-allele-order \
       --out pruned

   #----- Prepare Africa pops for pca and fst
   plink \
       --vcf ${phase}qc1kgp_merge.vcf.gz \
       --extract msl.rsids \
       --recode \
       --double-id \
       --maf ${amaf} \
       --keep-allele-order \
       --autosome \
       --threads 30 \
       --out CONVERTF/afr
   
   rm CONVERTF/*.nosex
   else 
       echo """
  	Usage:./prepWorldpops.sh <wmaf> <amaf>

   	wmaf: MAF for PCA and Fst with World pops
   	amaf: MAF for PCA and Fst with Afr pops
   """
fi
