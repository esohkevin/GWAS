#!/bin/bash
#grep Warning imputed.log | awk '{print $3}' | sed -e s/\'//g > warnings.txt
#grep Warning imputed.log | awk '{print $5}' | sed -e s/\'//g >> warnings.txt

#plink --vcf ../phase/imputed/chr18_imputed.vcf.gz --vcf-min-gp 0.75 --maf 0.01 --hwe 1e-08 --make-bed --imputed

#plink --bfile ../phase/imputed/imputed --list-duplicate-vars --out dups
#plink --bfile imputed --exclude dups.dupvar --make-bed --out imputed_temp --geno 0.10

plink --bfile ../../phase/allimp/imputed --update-sex ../qc-camgwas-updated.fam 3 --pheno ../qc-camgwas-updated.fam --mpheno 4 --make-bed --out imputed_temp --geno 0.10 --mind 0.10 --maf 0.01
plink --bfile imputed_temp --make-bed --out imputed_clean --hwe 1e-06
rm imputed_temp*
