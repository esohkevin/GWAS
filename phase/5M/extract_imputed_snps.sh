#!/usr/bin/env bash

bcftools view -i 'INFO/AF>0.01 && INFO/IS>=0.80' imputed.info.vcf.gz | bcftools view -e 'INFO/VT!="SNP"' | bcftools query -f '%ID\n' > r2_0.80.snp.txt

#for chr in {1..22}; do
#   bcftools view -i 'INFO/AF>0.01 && INFO/IS>=0.80' chr${chr}.info.vcf.gz | bcftools view -e 'INFO/VT!="SNP"' | bcftools query -f '%ID\n'
#done > r2_0.80.snp.txt
