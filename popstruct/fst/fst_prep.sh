#!/bin/bash

if [[ $# == 3 ]]; then
   
    in_vcf="$1"
    maf="$2"
    outname="$3"

    #-------- LD-prune the raw data
    plink1.9 \
        --vcf ${in_vcf} \
        --allow-no-sex \
	--aec \
	--autosome \
	--double-id \
	--keep-allele-order \
        --indep-pairwise 5k 100 0.1 \
        --out pruned

    #-------- Now extract the pruned SNPs to perform check-sex on
    plink1.9 \
        --vcf ${in_vcf} \
        --allow-no-sex \
	--maf ${maf} \
	--aec \
	--autosome \
	--keep-allele-order \
        --extract pruned.prune.in \
        --recode A \
	--double-id \
        --out ${outname}
    
    #-------- Pull sample IDs based on column number
    #awk '{print $1, $1, $17}' ../eig/EIGENSTRAT/merged.pca.evec | sed '1d' | grep -v NA > stat.txt
    #awk '{print $1, $1, $15}' ../eig/EIGENSTRAT/merged.pca.evec | sed '1d' | grep -v NA > dsex.txt
    #awk '{print $1, $1, $19}' ../eig/EIGENSTRAT/merged.pca.evec | sed '1d' | grep -v NA > alt.txt
    #awk '{print $1, $1, $20}' ../eig/EIGENSTRAT/merged.pca.evec | sed '1d' | grep -v NA > age.txt
    #awk '{print $1, $1, $21}' ../eig/EIGENSTRAT/merged.pca.evec | sed '1d' | grep -v NA > para.txt

    rm pruned* *.nosex

else
    echo """
    Usage:./fst_prep.sh <in-vcf(plus path)> <maf> <bfile-outname>
    """
fi
