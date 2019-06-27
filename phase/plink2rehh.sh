#!/bin/bash

if [[ $# != 5 ]]; then
   echo """
	Usage: ./rehhPrep.sh <in-phased-vcf> <chr#> <from-kb> <to-kb> <pop-name>
   """
else

   # Make Plink .bim file
   plink \
   	--vcf $1 \
   	--make-bed \
   	--chr $2 \
   	--from-kb $3 \
   	--to-kb $4 \
   	--keep-allele-order \
   	--out chr${2}$5
   
   # Make Plink .tped file
   plink \
   	--vcf $1 \
   	--recode transpose \
   	--chr $2 \
   	--from-kb $3 \
   	--to-kb $4 \
   	--keep-allele-order \
   	--out chr${2}$5
   
   Rscript rehhPrep.R chr${2}$5.bim chr${2}$5.map chr${2}$5.tped chr${2}$5-updated.hap
#   rm chr${2}$5.bim chr${2}$5.bed chr${2}$5.fam
fi
