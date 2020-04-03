#!/usr/bin/env bash

chr=$1

kgp="${HOME}/Git/GWAS/1000G/"

if [ $# -lt 1 ]; then
   echo "Usage: ./info.hdr.sh <chr#>"
elif [[ -f "chr${chr}.info.vcf.gz" ]]; then
   echo -e "chr${chr}.info.vcf.gz already exists! Skipping ..." 1>&2;
   exit 1;
else
#for chr in {1..22}; do
echo -e """##fileformat=VCFv4.2
##contig=<ID=${chr}>
##INFO=<ID=VT,Number=.,Type=String,Description=\"indicates what type of variant the line represents\">
##INFO=<ID=AF,Number=A,Type=Float,Description=\"Allele Frequency (expected allele frequency)\">
##INFO=<ID=IS,Number=1,Type=Float,Description=\"Info Score (IMPUTE2)\">
##INFO=<ID=CT,Number=1,Type=Float,Description=\"Certainty\">
##INFO=<ID=TY,Number=1,Type=Float,Description=\"Type\">
##INFO=<ID=IO,Number=1,Type=Float,Description=\"Info Type 0\">
##INFO=<ID=CO,Number=1,Type=Float,Description=\"Concord Type 0\">
##INFO=<ID=RO,Number=1,Type=Float,Description=\"r2 Type 0\">
#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO""" > chr${chr}.temp.vcf
#done

cut -f2- -d' ' chr${chr}_imputed.gen.info | awk -v chrom="$chr" '{print chrom"\t"$2"\t"$1"\t"$3"\t"$4"\t"".""\t"".""\t""AF="$5";""IS="$6";""CT="$7";""TY="$8";""IO="$9";""CO="$10";""RO="$11}' >> chr${chr}.temp.vcf
bgzip -@ 10 -f chr${chr}.temp.vcf
bcftools sort chr${chr}.temp.vcf.gz -Oz -o chr${chr}.temp.vcf.gz
bcftools index --threads 30 -f -t chr${chr}.temp.vcf.gz
bcftools annotate --threads 30 -c CHROM,POS,ID,REF,ALT,INFO/VT -a ${kgp}Phase3_merged.vcf.gz chr${chr}.temp.vcf.gz -Oz -o chr${chr}.info.vcf.gz
bcftools index --threads 30 -f -t chr${chr}.info.vcf.gz
rm chr${chr}.temp*
fi


#seq 1 22 | parallel echo "-@ 10 -f chr{}.temp.vcf" | xargs -n4 -P5 bgzip
#seq 1 22 | parallel echo "sort chr{}.temp.vcf.gz -Oz -o chr{}.temp.vcf.gz" | xargs -n5 -P5 bcftools
#seq 1 22 | parallel echo "index --threads 30 -f -t chr{}.temp.vcf.gz" | xargs -n6 -P5 bcftools
#bcftools concat --threads 10 -a -d all chr{1..22}.temp.vcf.gz -Oz -o imputed.temp.vcf.gz
#bcftools index --threads 30 -f -t imputed.temp.vcf.gz
#bcftools annotate --threads 30 -c CHROM,POS,ID,REF,ALT,INFO/VT -a ${kgp}Phase3_merged.vcf.gz imputed.temp.vcf.gz -Oz -o imputed.info.vcf.gz

