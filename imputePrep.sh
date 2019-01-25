#!/usr/bin/env bash

# Prepare genotype files for Sanger Imputation Service

# Get dbSNP annotation file for refernce SNPs (Accessed: January 22nd, 2019 - 10:08am)
#wget ftp://ftp.ncbi.nih.gov/snp/organisms/human_9606_b151_GRCh37p13/VCF/All_20180423.vcf.*

# Extract all SNPs in the file into a new file
#grep "^#" VCF/All_20180423.vcf.gz | cut -f 

### Extract Palimcromic SNPs and prepare chromosomes for imputation services ###
# Compute allel frequencies
plink \
	--bfile qc-camgwas \
	--allow-no-sex \
	--freq \
	--out qc-camgwas

# Now extract palindromic SNPs in R for subsequent exclusion
R CMD BATCH palindromicsnps.R
