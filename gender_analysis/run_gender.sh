#!/bin/bash

# Paths
popstruct="$HOME/GWAS/Git/GWAS/popstruct"
assocResults="$HOME/GWAS/Git/GWAS/assoc_results"
samples="$HOME/GWAS/Git/GWAS/samples"
analysis="$HOME/GWAS/Git/GWAS/analysis"

plink2 \
	--bfile $analysis/qc-camgwas-eig-corrected \
  	--keep-allele-order \
  	--keep-males \
  	--make-bed \
  	--out qc-camgwas-eig-corrected-males

plink2 \
        --bfile $analysis/qc-camgwas-eig-corrected \
        --keep-allele-order \
        --keep-females \
        --make-bed \
        --out qc-camgwas-eig-corrected-females


./run_female-pipeline.sh
./run_male-pipeline.sh
