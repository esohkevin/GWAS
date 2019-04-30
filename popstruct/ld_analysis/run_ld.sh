#!/bin/bash

# Generate LD report for qc-camgwas-updated
## Outputting binary matrix format
plink \
	--bfile ../../analysis/qc-camgwas-updated \
	--allow-no-sex \
	--r2 bin gz yes-really \
	--autosome \
#	--parallel \
	--out qc-camgwas-r2bin

## Outputting squared table format with D' and MAfs
plink \
        --bfile ../../analysis/qc-camgwas-updated \
        --allow-no-sex \
	--autosome \
        --r2 inter-chr gz yes-really \
 #       --parallel \
        --out qc-camgwas-r2D

## Outputting haplotype frequencies,r2 and D'
#plink \
#        --bfile ../../analysis/qc-camgwas-updated \
#       --allow-no-sex \
#        --autosome \
#        --ld \
#        --parallel \
#        --out qc-camgwas-rld

