#!/bin/bash

#for i in $(cat ../world/pop.list); do 
#   grep -wi $i ../world/pca_eth_world_pops.txt | \
#      shuf -n50; done | \
#      awk '{print $1,$1}' > world50.ids
#plink --vcf alder.vcf.gz --indep-pairwise 5kb 10 0.01 --keep-allele-order --extract ../world/POPGEN/wld.fstsnps.txt --double-id --out prune
plink --vcf alder.vcf.gz --recode --keep-allele-order --geno 0.05 --double-id --extract ../world/POPGEN/wld.fstsnps.txt --keep qc-world-pop.ids --out world

convertf -p par.PED.PACKEDPED
convertf -p par.PACKEDPED.PACKEDANCESTRYMAP
convertf -p par.PACKEDANCESTRYMAP.ANCESTRYMAP
convertf -p par.ANCESTRYMAP.EIGENSTRAT

Rscript prep_indfile.R
