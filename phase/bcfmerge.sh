#!/bin/bash

#for i in chr*-phased_wref.vcf.gz; do
#    tabix -f -p vcf ${i}
#done


# bcftools concat -a -d snps -Oz \
# chr1-phased_wref.vcf.gz \
# chr2-phased_wref.vcf.gz \
# chr3-phased_wref.vcf.gz \
# chr4-phased_wref.vcf.gz \
# chr5-phased_wref.vcf.gz \
# chr6-phased_wref.vcf.gz \
# chr7-phased_wref.vcf.gz \
# chr8-phased_wref.vcf.gz \
# chr9-phased_wref.vcf.gz \
# chr10-phased_wref.vcf.gz \
# chr11-phased_wref.vcf.gz \
# chr12-phased_wref.vcf.gz \
# chr13-phased_wref.vcf.gz \
# chr14-phased_wref.vcf.gz \
# chr15-phased_wref.vcf.gz \
# chr16-phased_wref.vcf.gz \
# chr17-phased_wref.vcf.gz \
# chr18-phased_wref.vcf.gz \
# chr19-phased_wref.vcf.gz \
# chr20-phased_wref.vcf.gz \
# chr21-phased_wref.vcf.gz \
# chr22-phased_wref.vcf.gz \
# -o Phased_wref.vcf.gz

bcftools concat -a -d snps -Oz chr{1..22}-phased_wref.vcf.gz -o Phased_wref.vcf.gz
