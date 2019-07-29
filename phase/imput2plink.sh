#!/bin/bash

assocResults="../assoc_results/"

for chr in 11; do

   if [[ -f "chr${chr}impute2exclusion.list" ]]; then

      rm chr${chr}impute2exclusion.list

   fi


   for chunk in chr${chr}_*_imputed.gen_info; do  					# Check all chunks per chr with successful imputation

        sed '1d' $chunk | awk '$7<0.75' | cut -f2 -d' ';  
    
   done > chr${chr}impute2exclusion.list;

done


#if [[ -f "merge.list" ]]; then
#
#      rm merge.list
#
#fi


for chr in 11; do

    echo chr${chr} >> merge.list

    plink \
	--oxford-single-chr ${chr} \
	--gen chr${chr}_imputed.gen.gz \
	--maf 0.0001 \
	--sample phasedWref.sample \
	--make-bed \
	--hwe 1e-20 \
	--exclude chr${chr}impute2exclusion.list \
	--hard-call-threshold 0.01 \
	--out chr${chr}
done


#plink \
#	--merge-list merge.list \
#	--keep-allele-order \
#	--out phasedWrefImpute2
#
plink \
	--bfile chr11 \
	--list-duplicate-vars ids-only suppress-first \
	--keep-allele-order \
	--out dups

plink \
        --bfile chr11 \
	--exclude dups.dupvar \
	--keep-allele-order \
	--make-bed \
	--out chr11
#
#for chr in {1..22}; do
#    rm chr${chr}.bim chr${chr}.bed chr${chr}.fam chr${chr}.log
#done


cut -f1,4 chr11.bim | \
	sed 's/\t/:/g' > chr11.pos
cut -f2 chr11.bim > chr11.ids
paste chr11.ids chr11.pos > chr11-ids-pos.txt

plink \
	--bfile chr11 \
	--update-name chr11-ids-pos.txt 2 1 \
	--allow-no-sex \
	--make-bed \
	--out chr11

plink \
	--bfile chr11 \
	--update-name updateName.txt 1 2 \
	--allow-no-sex \
	--make-bed \
	--out chr11-updated

