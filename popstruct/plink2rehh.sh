#!/bin/bash

#if [[ $# != 5 ]]; then
#   echo """
#	Usage: ./rehhPrep.sh <in-phased-vcf> <chr#> <from-kb> <to-kb> <pop-name>
#   """
#else
#
#   # Make Plink .bim file
#   plink \
#   	--vcf $1 \
#   	--make-bed \
#   	--chr $2 \
#	--reference-allele Force-Allele1-cam11-1000G.txt \
#	--keep controls558.ids.txt \
#	--double-id \
#   	--from-kb $3 \
#   	--to-kb $4 \
#   	--out chr${2}$5
#   
##   # Make Plink .tped file
##   plink \
##   	--vcf $1 \
##   	--recode transpose \
##	--keep controls558.ids.txt \
##        --double-id \
##	--reference-allele Force-Allele1-cam11-1000G.txt \
##   	--chr $2 \
##   	--from-kb $3 \
##   	--to-kb $4 \
##   	--out chr${2}$5
#
## Make Oxford haps file
#plink2 \
#	--vcf $1 \
#	--export haps \
#	--keep controls558.ids.txt \
#	--out chr${2}$5 \
#	--double-id \
#	--from-kb $3 \
#	--to-kb $4 \
#	--chr $2
#   
#   Rscript rehhPrep.R chr${2}$5.bim chr${2}$5.map chr${2}$5.haps tmp.txt
##   rm chr${2}$5.bim chr${2}$5.bed chr${2}$5.fam
#
#sed 's/1/2/g' tmp.txt | sed 's/0/1/g' > chr${2}$5-updated.hap
#
#fi
#

# Chr11 HBB 2Mb (5200-5400) region
plink2 \
	--chr 11 \
	--export hapslegend \
	--vcf ../phase/Phased_wref.vcf.gz \
	--out chr11hbb \
	--from-kb 5000 \
	--to-kb 5400 \
	--keep controls558.ids.txt \
	--double-id

sed '1d' chr11hbb.legend | awk '{print $1"\t""11""\t"$2"\t"$3"\t"$4}' > chr11hbb.map
sed 's/1/2/g' chr11hbb.haps | sed 's/0/1/g' > chr11hbb.hap

# Entire chr11
plink2 \
        --chr 11 \
        --export hapslegend \
        --vcf ../phase/Phased_wref.vcf.gz \
        --out chr11 \
        --keep controls558.ids.txt \
        --double-id

sed '1d' chr11.legend | awk '{print $1"\t""11""\t"$2"\t"$3"\t"$4}' > chr11.map
sed 's/1/2/g' chr11.haps | sed 's/0/1/g' > chr11.hap

