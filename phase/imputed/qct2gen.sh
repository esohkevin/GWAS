#!/bin/bash

if [[ $# != 1 ]]; then
   echo """
   Usage: ./qct2gen.sh <hardcall-threshold>
   """
else
   hc=$1
   if [[ -f merge.list ]]; then
       rm merge.list
   fi
   for chr in {1..22}; do
#     qctool_v2.0.1 \
#      -g chr${chr}_imputed.gen.gz \
#      -s samples.imputed \
#      -og chr${chr}_imputed.vcf \
#      -os chr${chr}_imputed.sample \
#      -precision 1 \
#      -threshold $hc \
#      -assume-chromosome $chr \
#      -threads 60 \
#      -incl-rsids chr${chr}_imputed.gen.include \
#      -ofiletype vcf \
#      -sort
#     bgzip chr${chr}_imputed.vcf
#     bcftools query -f '%ID\n' chr${chr}_imputed.vcf.gz | sort | uniq -d > chr${chr}.exclude
#     plink2 \
#      --vcf chr${chr}_imputed.vcf.gz \
#      --make-bed \
#      --exclude chr${chr}.exclude \
#      --covar ../analysis/cor.pca.txt \
#      --covar-name C1-C10  \
#      --keep-allele-order \
#      --pheno ../analysis/qc-camgwas-updated.fam \
#      --pheno-col-nums 6 \
#      --update-sex ../analysis/qc-camgwas-updated.fam col-num=5 \
#      --double-id \
#      --out chr${chr} \
#      --maf 0.01
#     echo chr${chr} >> merge.list
   plink --vcf chr${chr}_imputed.vcf.gz --vcf-min-gp $hc --maf 0.01 --hwe 1e-08 --make-bed --out chr${chr}
   echo chr${chr} >> merge.list
   done
   plink \
      --merge-list merge.list \
      --keep-allele-order \
      --out imputed

fi
