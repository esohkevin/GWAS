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
	--reference-allele Force-Allele1-cam11-1000G.txt \
	--keep controls558.ids.txt \
	--double-id \
   	--from-kb $3 \
   	--to-kb $4 \
   	--out chr${2}$5
   
#   # Make Plink .tped file
#   plink \
#   	--vcf $1 \
#   	--recode transpose \
#	--keep controls558.ids.txt \
#        --double-id \
#	--reference-allele Force-Allele1-cam11-1000G.txt \
#   	--chr $2 \
#   	--from-kb $3 \
#   	--to-kb $4 \
#   	--out chr${2}$5

# Make Oxford haps file
plink2 \
	--vcf $1 \
	--export haps \
	--keep controls558.ids.txt \
	--out chr${2}$5 \
	--double-id \
	--from-kb $3 \
	--to-kb $4 \
	--chr $2
   
   Rscript rehhPrep.R chr${2}$5.bim chr${2}$5.map chr${2}$5.haps tmp.txt
#   rm chr${2}$5.bim chr${2}$5.bed chr${2}$5.fam

sed 's/1/2/g' tmp.txt | sed 's/0/1/g' > chr${2}$5-updated.hap

fi


