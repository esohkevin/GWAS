#!/usr/bin/env bash

ref="../analysis/human_g1k_v37.fasta"
vcfbase="raw-updated"

#echo "`tabix -f -p vcf "${vcfbase}".vcf.gz`"
#echo "`bcftools sort "${vcfbase}".vcf.gz -Oz -o "${vcfbase}".vcf.gz`"
#echo "`bcftools view -m2 -M2 -Oz ${vcfbase}.vcf.gz -o ${vcfbase}-b2.vcf.gz`"
echo "`checkVCF.py -r "$ref" -o out "${vcfbase}"-b2.vcf.gz`"
echo "`bcftools index "${vcfbase}"-b2.vcf.gz`"

