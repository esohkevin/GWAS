#!/bin/bash


for chr in {1..22}; do

   if [[ -f "chr${chr}impute2exclusion.list" ]]; then

      rm chr${chr}impute2exclusion.list

   fi


   for chunk in chr${chr}_*_imputed.gen_info; do  					# Check all chunks per chr with successful imputation

        sed '1d' $chunk | awk '$7<0.75' | cut -f2 -d' ';  
    
   done > chr${chr}impute2exclusion.list;

done


if [[ -f "merge.list" ]]; then

      rm merge.list

fi


for chr in {1..22}; do

    echo chr${chr} >> merge.list

    plink \
	--oxford-single-chr ${chr} \
	--gen chr${chr}_imputed.gen.gz \
	--maf 0.01 \
	--sample phasedWref.sample \
	--make-bed \
	--hwe 1e-20 \
	--exclude chr${chr}impute2exclusion.list \
	--hard-call-threshold 0.01 \
	--out chr${chr}
done


plink \
	--merge-list merge.list \
	--keep-allele-order \
	--out phasedWrefImpute2

plink \
	--bfile phasedWrefImpute2 \
	--list-duplicate-vars ids-only suppress-first \
	--keep-allele-order \
	--out dups

plink \
        --bfile phasedWrefImpute2 \
	--exclude dups.dupvar \
	--keep-allele-order \
	--out phasedWrefImpute2

