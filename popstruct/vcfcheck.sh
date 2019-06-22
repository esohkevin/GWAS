#!/usr/bin/env bash

ref="../analysis/human_g1k_v37.fasta"
vcfbase="raw-updated"

echo "`tabix -f -p vcf "${vcfbase}".vcf.gz`"
echo "`bcftools sort "${vcfbase}".vcf.gz -Oz -o "${vcfbase}".vcf.gz`"
echo "`checkVCF.py -r "$ref" -o out "${vcfbase}".vcf.gz`"
echo "`bcftools index "${vcfbase}".vcf.gz`"
#mv "${vcfbase}".vcf.gz ../phase/

