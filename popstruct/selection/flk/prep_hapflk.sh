#!/bin/bash

if [[ $# == 1 ]]; then

    strap="$1"

    mkdir -p boot

    #for i in $(seq 1 ${strap}); do
    
        #---- Shuffle samples to get random perm for BA and SB (50 each)
        #shuf -n 50 sbantu.txt -o sbantu50.txt; awk '{print $1,$1,$2}' sbantu50.txt > perm${i}.txt
        #shuf -n 50 bantu.txt -o bantu50.txt; awk '{print $1,$1,$2}' bantu50.txt >> perm${i}.txt
        
        #---- Combine subsamples with 28 Fulbe individuals
        #awk '{print $1,$1,$2}' fulbe.txt >> perm${i}.txt

        #---- LD prune to retain partially linked loci
            plink \
                --vcf ../../Phased-pca-filtered.vcf.gz \
                --indep-pairwise 5k 50 0.3 \
                --keep-allele-order \
                --threads 30 \
                --out pruned \
                --autosome \
                --double-id \
                --allow-no-sex

            plink \
                --vcf ../../Phased-pca-filtered.vcf.gz \
                --allow-no-sex \
                --keep-allele-order \
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
                --keep pheno.txt \
                --maf 0.1 \
                --hwe 1e-8 \
                --keep-allele-order \
                --threads 30 \
                --out boot/cam \
                --double-id \
                --update-sex ../../../analysis/qc-camgwas-updated.fam 3

            Rscript prep.R pheno.txt boot/cam

            mv boot/cam.bed boot/camflk.bed
            mv boot/cam.bim boot/camflk.bim
            rm boot/cam.fam *.nosex pruned*

#	for chr in {1..22}; do
#        
#        #---- Make hapflk input with subsample and MAF >= 0.05
#            plink \
#                --bfile cam \
#                --make-bed \
#                --chr ${chr} \
#                --hwe 1e-8 \
#                --keep pheno.txt \
#                --maf 0.05 \
#                --keep-allele-order \
#                --threads 30 \
#                --out boot/cam-chr${chr} \
#                --double-id \
#                --update-sex ../../../analysis/qc-camgwas-updated.fam 3
#            
#            Rscript prep.R pheno.txt boot/cam-chr${chr}
#
#            cp boot/cam-chr${chr}.bed boot/cam-chr${chr}flk.bed
#            cp boot/cam-chr${chr}.bim boot/cam-chr${chr}flk.bim
#
#	    rm boot/cam-chr${chr}.bed boot/cam-chr${chr}.bim boot/cam-chr${chr}.fam boot/cam-chr${chr}.nosex
#    
#        done

    #done

else
    echo """
	Usage:./prep_hapflk.sh <#bootstrap>
    """
fi
