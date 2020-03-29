#!/usr/bin/env bash

sample="../../samples/"
analysis="../../analysis/"
#   --vcf-min-gq 0.95 \
#   --geno 0.05 \
#   --mind 0.10 \
if [ $# != 1 ]; then
   echo "Usage: ./vcf2plink <in-vcf>"
else
   inv=$1
   plink \
      --vcf ${inv} \
      --vcf-min-gp 0.90 \
      --biallelic-only \
      --double-id \
      --maf 0.01 \
      --geno 0.10 \
      --make-bed \
      --threads 60 \
      --exclude imputed.exclude \
      --allow-no-sex \
      --pheno "$analysis"raw-camgwas.fam \
      --update-sex "$analysis"raw-camgwas.fam 3 \
      --mpheno 4 \
      --out imputed
   
   plink \
      --bfile imputed \
      --hwe 1e-6 \
      --make-bed \
      --threads 50 \
      --out imputed_clean
fi
