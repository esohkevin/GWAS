#!/bin/bash

analysis="$HOME/GWAS/Git/GWAS/analysis/"


# Prune the eig-dataset for SNPs within 50bp with r^2 < 0.2 using a window of 5 SNPs
plink \
        --bfile "${analysis}"eig-camgwas-updated \
        --indep-pairwise 50 5 0.2 \
        --allow-no-sex \
        --autosome \
        --biallelic-only \
        --out eig-ldPruned
cat eig-ldPruned.log > eig-convertf.log

plink \
        --bfile "${analysis}"eig-camgwas-updated \
        --extract eig-ldPruned.prune.in \
        --allow-no-sex \
        --autosome \
        --make-bed \
        --out eig-camgwas-ldPruned
cat eig-camgwas-ldPruned.log >> eig-convertf.log

plink \
	--bfile eig-camgwas-ldPruned \
	--recode \
	--allow-no-sex \
	--keep-allele-order \
	--double-id \
	--out eig-camgwas
cat eig-camgwas.log >> eig-convertf.log

rm eig-ldPruned* eig-camgwas-ldPruned*

# Convert files into eigensoft compartible formats

echo -e "\n### PED to PACKEDPED ###" >> eig-convertf.log
convertf -p par.PED.PACKEDPED

echo -e "\n### PACKEDPED to PACKEDANCESTRYMAP ###" >> eig-convertf.log
convertf -p par.PACKEDPED.PACKEDANCESTRYMAP	

echo -e "\n### PACKEDANCESTRYMAP to ANCESTRYMAP ###" >> eig-convertf.log
convertf -p par.PACKEDANCESTRYMAP.ANCESTRYMAP	

echo -e "\n### ANCESTRYMAP to EIGENSTRAT ###" >> eig-convertf.log
convertf -p par.ANCESTRYMAP.EIGENSTRAT	

#convertf -p par.PED.EIGENSTRAT
