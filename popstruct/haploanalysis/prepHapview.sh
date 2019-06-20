#!/bin/bash


for pop in cam yri esn gwd msl lwk; do
    plink \
	--bfile ${pop} \
	--recode HV-1chr \
	--chr 11 \
	--from-kb 5200 \
	--to-kb 5400 \
	--geno 0.04 \
	--keep-allele-order \
	--out ~/bioTools/haploview/${pop}
done
