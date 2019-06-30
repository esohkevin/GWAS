#!/bin/bash

if [[ $# != 3 ]]; then
   echo """
	Usage: ./rehhPrep.sh <chr#> <from-kb> <to-kb>
   """
else

   # Chr11 HBB 2Mb (5200-5400) region
   plink2 \
   	--chr $1 \
   	--export hapslegend \
   	--vcf chr${1}-phased_wref.vcf.gz \
   	--out chr${1}hbb \
   	--from-kb $2 \
   	--to-kb $3 \
   	--keep controls558.ids.txt \
   	--double-id
   
   sed '1d' chr${1}hbb.legend | awk '{print $1"\t""11""\t"$2"\t"$4"\t"$3}' > chr${1}hbb.map
   sed 's/0/2/g' chr${1}hbb.haps > chr${1}hbb.hap
   
   # Entire chr11
   plink2 \
           --chr $1 \
           --export hapslegend \
           --vcf chr${1}-phased_wref.vcf.gz \
           --out chr$1 \
           --keep controls558.ids.txt \
           --double-id
   
   sed '1d' chr${1}.legend | awk '{print $1"\t""11""\t"$2"\t"$4"\t"$3}' > chr${1}.map
   sed 's/0/2/g' chr${1}.haps > chr${1}.hap
   
fi
