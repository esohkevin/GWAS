#!/bin/bash

#---- Shuffle samples to get random perm for BA and SB (50 each)
shuf -n 50 sbantu.txt -o sbantu50.txt; awk '{print $1,$1,$2}' sbantu50.txt > perm.txt
shuf -n 50 bantu.txt -o bantu50.txt; awk '{print $1,$1,$2}' bantu50.txt >> perm.txt

#---- Combine subsamples with 28 Fulbe individuals
awk '{print $1,$1,$2}' fulbe.txt >> perm.txt

#---- Make hapflk input with subsample and MAF >= 0.05
plink \
    --vcf ../../Phased-pca-filtered.vcf.gz \
    --recode \
    --keep perm.txt \
    --maf 0.05 \
    --keep-allele-order \
    --threads 15 \
    --out cam \
    --double-id \
    --update-sex ../../../analysis/qc-camgwas-updated.fam 3

Rscript prep.R
