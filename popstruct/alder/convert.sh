#!/bin/bash

for i in $(cat ../pca/pop.list); do 
   grep -wi $i ../pca/pca_eth_world_pops.txt | \
      shuf -n50; done | \
      awk '{print $1,$1}' > world50.ids
#plink --vcf alder.vcf.gz --double-id --maf 0.05 --indep-pairwise 50 10 0.3 --out prune --keep-allele-order
plink --vcf alder.vcf.gz --double-id --indep-pairwise 50kb 10 0.0001 --out prune --keep-allele-order
plink --vcf alder.vcf.gz --recode --extract prune.prune.in --keep-allele-order --double-id --out world --keep world50.ids

convertf -p par.PED.PACKEDPED
convertf -p par.PACKEDPED.PACKEDANCESTRYMAP
convertf -p par.PACKEDANCESTRYMAP.ANCESTRYMAP
convertf -p par.ANCESTRYMAP.EIGENSTRAT

#Rscript prep_indfile.R
./../pca/prepIndFile.sh ../pca/fst.metadata.txt world.ind
mv world.fst.ind world-ald.ind 
