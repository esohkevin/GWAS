#!/bin/bash

if [[ $# == [2] ]]; then

    maf="$1"
    outgrp="$2"

    mkdir -p boot

    #for i in $(seq 1 ${strap}); do
    
        #---- Shuffle samples to get random perm for BA and SB (50 each)
        #shuf -n 50 sbantu.txt -o sbantu50.txt; awk '{print $1,$1,$2}' sbantu50.txt > perm${i}.txt
        #shuf -n 50 bantu.txt -o bantu50.txt; awk '{print $1,$1,$2}' bantu50.txt >> perm${i}.txt
        
        #---- Combine subsamples with 28 Fulbe individuals
        #awk '{print $1,$1,$2}' fulbe.txt >> perm${i}.txt

        grep -wi -e "BA" -e "FO" -e "SB" -e $outgrp ../../world/pca_eth_world_pops.txt | awk '{print $1,$1,$3}' > cam_$outgrp.ids

                --threads 30 \
                --double-id \
                --extract pruned.prune.in \
                --make-bed \
                --out cam

	for chr in {1..22}; do
        
        #---- Make hapflk input with subsample and MAF >= 0.05
            plink \
                --bfile  \
                --make-bed \
                --chr ${chr} \
                --keep-allele-order \
                --threads 30 \
                --out boot/cam-chr${chr} \
                --double-id \
                --update-sex ../../../analysis/qc-camgwas-updated.fam 3
            
            Rscript prep.R cam_$outgrp.ids boot/cam-chr${chr}

            cp boot/cam-chr${chr}.bed boot/cam-chr${chr}flk.bed
            cp boot/cam-chr${chr}.bim boot/cam-chr${chr}flk.bim

	    rm boot/cam-chr${chr}.bed boot/cam-chr${chr}.bim boot/cam-chr${chr}.fam boot/cam-chr${chr}.nosex
    
        done

else
    echo -e """
	Usage:./prep_hapflk.sh <maf> <outgrp [e.g. gbr]>

	      \e[33;5;38mImportant!\e[0m
	     If no outgroup, use the pop code of any of your pops (e.g. sb)
    """
fi
