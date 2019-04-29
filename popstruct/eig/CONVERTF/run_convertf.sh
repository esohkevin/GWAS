#!/bin/bash

# Prune the qc-dataset for SNPs within 50bp with r^2 < 0.2 using a window of 5 SNPs
plink \
        --bfile ../../../analysis/qc-camgwas-updated \
        --indep-pairwise 50 5 0.2 \
        --allow-no-sex \
        --autosome \
        --biallelic-only \
        --out qc-ldPruned

plink \
        --bfile ../../../analysis/qc-camgwas-updated \
        --extract qc-ldPruned.prune.in \
        --allow-no-sex \
        --autosome \
        --make-bed \
        --out qc-camgwas-ldPruned

plink \
	--bfile qc-camgwas-ldPruned \
	--recode \
	--allow-no-sex \
	--keep-allele-order \
	--double-id \
	--out qc-camgwas

# Convert files into eigensoft compartible formats
convertf -p par.PED.PACKEDPED 	# ped to packedped
convertf -p par.PACKEDPED.PACKEDANCESTRYMAP	# packedped to packedancestrymap
convertf -p par.PACKEDANCESTRYMAP.ANCESTRYMAP	# packedancestrymap to ancestrymap
convertf -p par.ANCESTRYMAP.EIGENSTRAT	# ancestrymap to eigenstrat

