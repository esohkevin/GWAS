#!/bin/bash

if [[ $# != 4 ]]; then
   echo """
	Usage: mafCam.sh <chr#> <from-kb> <to-kb> <gene-name>
"""
else
#	for eth in bantu semibantu; do
#	    plink \
#		--bfile camgwasPhasedWref \
#		--keep ${eth}.txt \
#		--keep-allele-order \
#		--out ${eth} \
#		--make-bed \
#		--thin-indiv-count 30
#	done
#	
#	plink \
#		--merge-list merge.list \
#		--keep-allele-order \
#		--out cam30
#	
#	plink \
#		--bfile cam30 \
#		--freq \
#		--keep-allele-order \
#		--within cam1185.eth \
#		--out cam30
	
	plink \
	        --bfile cam \
	        --freq \
		--chr $1 \
		--from-kb $2 \
		--to-kb $3 \
	        --keep-allele-order \
	        --within cam1185.eth \
	        --out cam$4

fi

#./blocksCam.sh $1 $2 $3 $4 $5
