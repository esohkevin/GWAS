#!/bin/bash


#for pop in cam yri esn gwd msl lwk; do
#    plink \
#	--bfile ${pop} \
#	--recode HV-1chr \
#	--chr 11 \
#	--from-kb 5200 \
#	--to-kb 5400 \
#	--geno 0.04 \
#	--keep-allele-order \
#	--out ~/bioTools/haploview/${pop}
#done

#for pop in bantu semibantu; do
    plink \
        --vcf ../chr11-phased_wref.vcf.gz \
        --recode HV-1chr \
	--keep ../controls558.ids.txt \
	--double-id \
        --chr 11 \
        --from-kb 4500 \
        --to-kb 5800 \
        --keep-allele-order \
        --out ~/bioTools/haploview/cam
#done

