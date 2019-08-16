#!/bin/bash

#analysis="../../../analysis/"
#phase="../../../phase/"

vcf="$1"
outname="$2"

if [[ $# == 3 ]]; then

# Prune the qc-dataset for SNPs within 50bp with r^2 < 0.2 using a window of 5 SNPs
plink \
        --vcf "${vcf}" \
        --indep-pairwise 5k 5 0.05 \
        --allow-no-sex \
	--hwe 1e-8 \
	--keep $3 \
        --autosome \
	--double-id \
        --biallelic-only \
        --out qc-ldPruned

plink \
        --vcf "${vcf}" \
        --extract qc-ldPruned.prune.in \
        --allow-no-sex \
        --autosome \
	--keep $3 \
        --make-bed \
	--double-id \
        --out qc-camgwas-ldPruned

plink \
	--bfile qc-camgwas-ldPruned \
	--recode \
	--allow-no-sex \
	--double-id \
	--out ${outname}

rm qc-ldPruned* qc-camgwas-ldPruned*

# Convert files into eigensoft compartible formats

echo -e "\n### PED to PACKEDPED ###" >> convertf.log
convertf -p par.PED.PACKEDPED >>convertf.log

echo -e "\n### PACKEDPED to PACKEDANCESTRYMAP ###" >> convertf.log
convertf -p par.PACKEDPED.PACKEDANCESTRYMAP >>convertf.log	

echo -e "\n### PACKEDANCESTRYMAP to ANCESTRYMAP ###" >> convertf.log
convertf -p par.PACKEDANCESTRYMAP.ANCESTRYMAP >>convertf.log

echo -e "\n### ANCESTRYMAP to EIGENSTRAT ###" >> convertf.log
convertf -p par.ANCESTRYMAP.EIGENSTRAT >>convertf.log

#convertf -p par.PED.EIGENSTRAT

else
	echo """
	Usage: ./convertf_all.sh <in-vcf> <outname> <keep>
	"""
fi
