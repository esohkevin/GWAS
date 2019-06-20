#!/bin/bash

analysis="../../analysis/"
world="../eig/world/worldPops/"
phase="../../phase/"
kgp="${phase}1000GP_Phase3/"
sample="../../samples/"

if [[ $# != 5 ]]; then
   echo """
        Usage: mafWorld.sh <chr#> <from-kb> <to-kb> <gene-name>
"""
else

	if [[ -f "worldMergeList.txt" ]]; then
	   rm worldMergeList.txt
	fi

	plink \
		--bfile ${world}../cam-controls \
		--keep-allele-order \
		--keep ${sample}cam.ids \
		--remove fulbe.txt \
		--make-bed \
		--maf 0.0001 \
		--out cam

	echo "cam" > worldMergeList.txt
	
	for pop in gwd lwk yri esn msl; do
	    plink \
		--bfile ${world}mergedSet \
		--keep ${sample}${pop}.ids \
		--keep-allele-order \
		--out ${pop} \
		--make-bed \
		--update-sex ${world}update-1kgp.sex 1 \
		--maf 0.0001
	
		echo ${pop} >> worldMergeList.txt
	done
	
	plink \
		--merge-list worldMergeList.txt \
		--keep-allele-order \
		--out world
	
	plink \
		--bfile world \
		--freq \
		--keep-allele-order \
		--within camAfr.cluster \
		--out world
	
	plink \
	        --bfile world \
	        --freq \
		--chr $1 \
		--from-kb $2 \
		--to-kb $3 \
	        --keep-allele-order \
	        --within camAfr.cluster \
	        --out world$4
fi

./blocksWorld.sh $1 $2 $3 $4 $5
