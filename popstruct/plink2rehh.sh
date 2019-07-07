#!/bin/bash

if [[ $# != 4 ]]; then
   echo """
	Usage: ./rehhPrep.sh <chr#> <from-kb> <to-kb> <pop-name>
   """
else

   # Chr11 HBB 2Mb (5200-5400) region
   plink2 \
   	--chr $1 \
   	--export hapslegend \
   	--vcf chr${1}-phased_wref.vcf.gz \
   	--out chr${1}${4}hbb \
   	--from-kb $2 \
   	--to-kb $3 \
   	--keep $4.txt \
   	--double-id
   
   sed '1d' chr${1}${4}hbb.legend | awk '{print $1"\t""11""\t"$2"\t"$4"\t"$3}' > chr${1}${4}hbb.map
   sed 's/0/2/g' chr${1}${4}hbb.haps > chr${1}${4}hbb.hap
   
   # Entire chr11
   plink2 \
           --chr $1 \
           --export hapslegend \
           --vcf chr${1}-phased_wref.vcf.gz \
           --out chr$1$4 \
           --keep $4.txt \
           --double-id
  
   sed '1d' chr${1}${4}.legend | awk '{print $1"\t""11""\t"$2"\t"$4"\t"$3}' > chr${1}${4}.map
   sed 's/0/2/g' chr${1}${4}.haps > chr${1}${4}.hap
   
fi
