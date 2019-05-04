#!/bin/bash

# Generate LD report for qc-camgwas-updated
## Outputting binary matrix format
#plink \
#	--bfile ../../analysis/qc-camgwas-updated \
#	--allow-no-sex \
#	--r2 bin triangle yes-really \
#	--autosome \
#	--out qc-camgwas-r2bin

## Outputting squared table format with D' and MAfs
plink \
        --bfile ../../analysis/qc-camgwas-updated \
        --allow-no-sex \
	--chr 6 \
	--from-bp 28477797 \
	--to-bp 33448354 \
        --r2 bin4 square yes-really \
        --out chr6Mhc-bin

# A Square matrix
plink \
        --bfile ../../analysis/qc-camgwas-updated \
        --allow-no-sex \
        --chr 6 \
        --from-bp 28477797 \
        --to-bp 33448354 \
        --r2 square yes-really \
        --out chr6Mhc-ld

## Outputting haplotype frequencies,r2 and D'
#plink \
#        --bfile ../../analysis/qc-camgwas-updated \
#       --allow-no-sex \
#        --autosome \
#        --ld \
#        --parallel \
#        --out qc-camgwas-rld

