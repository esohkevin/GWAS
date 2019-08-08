#!/bin/bash

#echo 'If pulling from github, change --geneticMapFile to ../tables/genetic_map_hg19_example.txt.gz'
#echo

ref_path="$HOME/GWAS/Git/GWAS/1000G"

if [[ $1 == "1" ]]; then
   
   echo "`tabix -f -p vcf qc-camgwas-updated.vcf.gz`"
   
   for chr in {1..22}; do
     eagle \
       --vcfRef=${ref_path}/ALL.chr${chr}.phase3_integrated.20130502.genotypes.bcf \
       --vcfTarget=qc-camgwas-updated.vcf.gz \
       --geneticMapFile=tables/genetic_map_hg19_withX.txt.gz \
       --outPrefix=chr${chr}-phased_wref \
       --chrom=${chr} \
       --pbwtIters=10 \
       --numThreads=90 \
       --Kpbwt=50000 \
       --vcfOutFormat=z \
       2>&1 | tee chr${chr}-phased_wref.log
   
     echo "`tabix -f -p vcf chr${chr}-phased_wref.vcf.gz`"
   
   done
   
   # --vcfOutFormat: Specify output format (.vcf, .vcf.gz, or .bcf)
   # --noImpMissing: Turn off imputation of missing genotypes
   # --bpStart=50e6, --bpEnd=100e6, and --bpFlanking=1e6: Impute genotypes to specific regions
   # --Kpbwt=10000: Adjust speed and accuracy of impuatation. Increase value to improve accuracy


elif [[ $1 == "2" ]]; then
     # Phasing imputed data
     
     for chr in 11; do
     
         tabix -f -p vcf chr${chr}-imputed.vcf.gz
         
         eagle \
             --vcfRef=${ref_path}/ALL.chr${chr}.phase3_integrated.20130502.genotypes.bcf \
             --vcfTarget=chr${chr}-imputed.vcf.gz \
             --geneticMapFile=tables/genetic_map_hg19_withX.txt.gz \
             --outPrefix=chr${chr}-imp-phased_wref \
             --chrom=${chr} \
             --pbwtIters=10 \
             --numThreads=90 \
             --Kpbwt=50000 \
             --vcfOutFormat=z \
             2>&1 | tee chr${chr}-imp-phased_wref.log
         
           echo "`tabix -f -p vcf chr${chr}-imp-phased_wref.vcf.gz`"
     
     done

else
    echo "Please enter '1' or '2' for either unimputed or imputed data respectively"

fi
