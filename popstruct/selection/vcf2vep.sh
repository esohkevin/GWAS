#!/bin/bash

sort -nr --key=4 camSignals.txt | \
   awk '{print $1":"$2}' | \
   sort -n > signals.bp
zgrep -f signals.bp ../../analysis/updateName.txt.gz | \
   sort -n --key=2 > signals.rsids
rm signals.bp

plink \
   --vcf ../Phased-pca-filtered.vcf.gz \
   --recode vcf-fid \
   --extract signals.rsids \
   --keep-allele-order \
   --double-id \
   --allow-no-sex \
   --out ihsSignals \
   --real-ref-alleles \
   --thin-indiv-count 2
