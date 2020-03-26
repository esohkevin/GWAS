#!/bin/bash

home="$HOME/Git/GWAS/"
ana="${home}analysis/"

# chr16_imputed.gen.include_r2_0.5

qct2gen() {
if [[ $# != 4 ]]; then
   echo """
   Usage: ./qct2gen.sh <hardcall_threshold> <sample_file> <outprefx> <info>
   """
else
   hc=$1
   sf="$2"
   op=$3
   info=$4
   if [[ -f merge.list ]]; then
       rm merge.list
   fi
   for chr in {1..22}; do
     qctool_v2.0.1 \
      -g chr${chr}_imputed.gen.gz \
      -s $sf \
      -og chr${chr}_imputed.vcf \
      -os chr${chr}_imputed.sample \
      -precision 1 \
      -threshold $hc \
      -assume-chromosome $chr \
      -threads 60 \
      -incl-rsids chr${chr}_imputed.gen.include_r2_${info} \
      -ofiletype vcf \
      -sort
     bgzip -f -@ 30 chr${chr}_imputed.vcf
     bcftools index --threads 50 -f -t chr${chr}_imputed.vcf.gz
     #bcftools query -f '%ID\n' chr${chr}_imputed.vcf.gz | sort | uniq -d > chr${chr}.exclude
  #   plink \
  #    --vcf chr${chr}_imputed.vcf.gz \
  #    --double-id \
  #    --vcf-min-gp $hc \
  #    --maf 0.01 \
  #    --hwe 1e-08 \
  #    --update-sex ${ana}qc-camgwas-updated.fam 3 \
  #    --pheno ${ana}qc-camgwas-updated.fam \
  #    --mpheno 4 \
  #    --make-bed \
  #    --out chr${chr}
  # echo chr${chr} >> merge.list
   done
  # plink \
  #    --merge-list merge.list \
  #    --keep-allele-order \
  #    --out imputed
  # grep -i warning imputed.log | cut -f2 -d "'" > imputed.exclude
  # grep -i warning imputed.log | cut -f4 -d "'" >> imputed.exclude

   bcftools concat --threads 30 -D -a -Oz -o ${op}.r2_${info}.vcf.gz chr{1..22}_imputed.vcf.gz
fi
}
