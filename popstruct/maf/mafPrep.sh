#!/bin/bash

world="../eig/world/"
analysis="../../analysis/"

cut -f2 ${world}worldPops/phased-data-updated.bim > phased.rsids

# Extract only SNPs with rsIDs
plink \
        --bfile ${world}worldPops/world-pops-updated \
        --allow-no-sex \
	--maf 0.01 \
	--keep-allele-order \
        --extract phased.rsids \
        --make-bed \
        --out maf-data

cut -f2 maf-data.bim > maf-data.rsids
