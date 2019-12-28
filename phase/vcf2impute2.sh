#!/bin/bash

vcf2impute2() {
   sample_path="../samples/"
   analysis="../analysis/"
   assocResults="../assoc_results/"
   pop="../popstruct/"
   
   # Convert phased haplotypes in vcf format to IMPUTE2 .haps + .sample format   
   
   for chr in {1..22}; do
     if [[ -f "${phase_path}""chr${chr}-phased_wref.vcf.gz" ]]; then
        if [[ ! -f "chr${chr}-phased_wref.haps" ]]; then
           plink2 \
   	   --vcf ${pop}Phased-pca-filtered.vcf.gz \
   	   --export haps \
   	   --chr ${chr} \
   	   --covar ${assocResults}eig-corr-camgwas.pca.txt \
   	   --covar-name C1-C10 \
   	   --keep-allele-order \
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
