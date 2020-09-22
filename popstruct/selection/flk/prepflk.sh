#!/bin/bash

phase="../../../phase/"
p="$1"
maf="$2"
outgrp="$3"
ld="$4"

if [[ $# == 4 && $p == "flk" ]]; then

   mkdir -p boot

   #for i in $(seq 1 ${strap}); do
   
       #---- Shuffle samples to get random perm for BA and SB (50 each)
       #shuf -n 50 sbantu.txt -o sbantu50.txt; awk '{print $1,$1,$2}' sbantu50.txt > perm${i}.txt
       #shuf -n 50 bantu.txt -o bantu50.txt; awk '{print $1,$1,$2}' bantu50.txt >> perm${i}.txt
       
       #---- Combine subsamples with 28 Fulbe individuals
       #awk '{print $1,$1,$2}' fulbe.txt >> perm${i}.txt

       grep -wi -e "BA" -e "FO" -e "SB" -e $outgrp ../../world/pca_eth_world_pops.txt | awk '{print $1,$1,$3}' > cam_$outgrp.ids

       #---- LD prune to retain partially linked loci
           plink \
               --vcf ${phase}qc1kgp_merge.vcf.gz \
               --indep-pairwise 5kb 50 $ld \
               --keep-allele-order \
               --threads 30 \
               --keep cam_$outgrp.ids \
               --out pruned \
               --autosome \
               --double-id \
               --allow-no-sex

           plink \
               --vcf ${phase}qc1kgp_merge.vcf.gz \
               --allow-no-sex \
               --keep-allele-order \
               --keep cam_$outgrp.ids \
               --aec \
               --autosome \
               --threads 30 \
               --double-id \
               --extract pruned.prune.in \
               --make-bed \
               --out cam


       #---- Make hapflk input with subsample and MAF >= 0.2 (for flk on whole genome)
           plink \
               --bfile cam \
               --make-bed \
               --keep cam_$outgrp.ids \
               --maf $maf \
               --keep-allele-order \
               --threads 30 \
               --out boot/cam$outgrp \
               --double-id \
               --update-sex ../../world/pca_eth_world_pops.txt 1

           Rscript prep.R cam_$outgrp.ids boot/cam$outgrp

           mv boot/cam$outgrp.bed boot/cam${outgrp}flk.bed
           mv boot/cam$outgrp.bim boot/cam${outgrp}flk.bim
           rm boot/cam$outgrp.fam *.nosex pruned*

elif [[ $# == 3 && $p == "hflk" ]]; then

    for chr in {1..22}; do
    
    #---- Make hapflk input with subsample and MAF >= 0.05
        plink \
            --vcf ../../Phased-pca-filtered.vcf.gz \
            --make-bed \
            --chr ${chr} \
            --maf $maf \
            --allow-no-sex \
            --keep cam_$outgrp.ids \
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

#done

else
    echo -e """
	Usage:./prepflk.sh [flk|hflk] <maf> <outgrp [e.g. gbr]> <ldthresh>

		Enter 'flk' to run flk or 'hflk' to run hapflk
	      \e[33;5;38mImportant!\e[0m
	     If no outgroup, use the pop code of any of your pops (e.g. sb)
    """
fi
