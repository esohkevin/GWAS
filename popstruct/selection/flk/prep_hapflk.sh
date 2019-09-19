#!/bin/bash

if [[ $# == 1 ]]; then

    strap="$1"

    mkdir -p boot

    for i in $(seq 1 ${strap}); do
    
        #---- Shuffle samples to get random perm for BA and SB (50 each)
        shuf -n 50 sbantu.txt -o sbantu50.txt; awk '{print $1,$1,$2}' sbantu50.txt > perm${i}.txt
        shuf -n 50 bantu.txt -o bantu50.txt; awk '{print $1,$1,$2}' bantu50.txt >> perm${i}.txt
        
        #---- Combine subsamples with 28 Fulbe individuals
        awk '{print $1,$1,$2}' fulbe.txt >> perm${i}.txt

	for chr in {1..22}; do
        
        #---- Make hapflk input with subsample and MAF >= 0.05
            plink \
                --vcf ../../Phased-pca-filtered.vcf.gz \
                --recode \
                --chr ${chr} \
                --keep perm${i}.txt \
                --maf 0.05 \
                --keep-allele-order \
                --threads 30 \
                --out boot/cam-${i}chr${chr} \
                --double-id \
                --update-sex ../../../analysis/qc-camgwas-updated.fam 3
            
            Rscript prep.R perm${i}.txt boot/cam-${i}chr${chr}

	    rm boot/cam-${i}chr${chr}.ped boot/cam-${i}chr${chr}.map boot/cam-${i}chr${chr}.nosex
    
        done

    done

else
    echo """
	Usage:./prep_hapflk.sh <#bootstrap>
    """
fi
