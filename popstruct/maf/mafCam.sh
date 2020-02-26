#!/bin/bash

for i in BA FO SB; do grep wi $i ../pca/camWorld3577.eth | awk '{print $1,$1,$4}' | shuf -n50; done > cam50.ids 

for i in {1..30}; do
  plink \
     --vcf raw-camgwas.vcf.gz \
     --freq \
     --keep cam50.ids \
     --double-id \
     --keep-allele-order \
     --within cam50.ids \
     --out cam${i}
  awk '$7!="0" {print $2,$3,$6}' cam${i}.frq.strat > cam${i}.maf.frq
done
 
#vcftools \
#	--gzvcf raw-camgwas.vcf.gz \
#	--freq \
#	--stdout | \
#	    gzip -c > raw-camgwas.frq.gz

#zcat raw-camgwas.frq.gz | \
#    sed '1d' | \
#    awk '{print $1"\t"$2"\t"$5"\t"$6}' | \
#    sed 's/:/\t/g' | \
#    awk '$6!=0 {print $1"\t"$2"\t"$4"\t"$6}' > freqs_camgwas.txt

