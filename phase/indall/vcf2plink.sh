#!/usr/bin/env bash

sam="${HOME}/Git/GWAS/samples/"
analysis="${HOME}/Git/GWAS/analysis/"
assc="${HOME}/Git/GWAS/assoc_results/"
#   --vcf-min-gq 0.95 \
#   --geno 0.05 \
#   --mind 0.10 \
if [ $# != 5 ]; then
   echo "Usage: ./vcf2plink <in-vcf> <vcf-min-gp> <hwe> <geno> <info>"
else
   inv=$1
   gp=$2
   hwe=$3
   geno=$4
   is="$5"
#   plink \
#      --vcf ${inv} \
#      --vcf-min-gp $gp \
#      --biallelic-only \
#      --double-id \
#      --maf 0.01 \
#      --geno 0.10 \
#      --make-bed \
#      --threads 60 \
#      --allow-no-sex \
#      --pheno "$analysis"raw-camgwas.fam \
#      --update-sex "$analysis"raw-camgwas.fam 3 \
#      --mpheno 4 \
#      --out imputed

#   awk -v i="$is" '$7>i {print $2","$1}' all.snp.info > r2_${is}.snps.txt

   plink \
      --bfile imputed \
      --maf 0.05 \
      --extract r2_${is}.snps.txt \
      --geno ${geno} \
      --keep ${sam}include_bantu-semibantu.txt \
      --remove ${sam}exclude_fo.txt \
      --make-bed \
      --out temp1 \
      --mind 0.10

   plink \
      --bfile temp1 \
      --hwe ${hwe} \
      --make-bed \
      --out imputed_temp
  
   awk '{print $2}' imputed_temp.bim > subset_filtered.snplist
   cat ${assc}unimputed.snps ${assc}hbb_snps.snplist subset_filtered.snplist > merged.snplist

   plink \
       --bfile imputed \
       --extract merged.snplist \
       --remove ${sam}exclude_fo.txt \
       --make-bed \
       --out imputed_clean

fi
