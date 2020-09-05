#!/usr/bin/env bash

base="/mnt/lustre/groups/CBBI1243/KEVIN/git/GWAS/"
new="${base}new/"
sel="${new}selction/"

bcftools view -i 'GT=="het"' -r 11:5248232 ${new}filtered_r20.75_imputed.vcf.gz | bcftools query -f '%CHROM\t%POS\t%REF\t%ALT[\t%SAMPLE=%GT]\n' | cut -f5- | sed 's/\t/\n/g' | sed 's/=/\t/g' | awk '$2=="0|1" || $2=="1|0" {print $1"\t"$1"\t"$2}' > ${sel}HbAS.samples.txt
bcftools view -i 'GT=="het"' -r 11:5248232 ${new}filtered_r20.75_imputed.vcf.gz | bcftools query -f '%CHROM\t%POS\t%REF\t%ALT[\t%SAMPLE=%GT]\n' | cut -f5- | sed 's/\t/\n/g' | sed 's/=/\t/g' | awk '$2=="0|0" {print $1"\t"$1"\t"$2}' > ${sel}HbAA.samples.txt
bcftools view -i 'GT=="het"' -r 11:5248232 ${new}filtered_r20.75_imputed.vcf.gz | bcftools query -f '%CHROM\t%POS\t%REF\t%ALT[\t%SAMPLE=%GT]\n' | cut -f5- | sed 's/\t/\n/g' | sed 's/=/\t/g' | awk '$2=="1|1" {print $1"\t"$1"\t"$2}' > ${sel}HbSS.samples.txt

bcftools view -v snps -m2 -M2 -i 'AF>=0.01' -r 11:4248232-6248232 ${new}filtered_r20.75_imputed.vcf.gz --threads 24 -Oz -o ${sel}hbb.vcf.gz


