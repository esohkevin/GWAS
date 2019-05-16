#!/usr/bin/env bash

1kgp_path="$HOME/GWAS/Git/GWAS/phase/1000GP_Phase3/"

####################################################################################################
# Prepare genotype files for Sanger Imputation Service

# Get dbSNP annotation file for refernce SNPs (Accessed: January 22nd, 2019 - 10:08am)
#wget ftp://ftp.ncbi.nih.gov/snp/organisms/human_9606_b151_GRCh37p13/VCF/All_20180423.vcf.*

# Extract all SNPs in the file into a new file
#grep "^#" VCF/All_20180423.vcf.gz | cut -f 
####################################################################################################

echo "### Extract Palimcromic SNPs and prepare chromosomes for imputation services ###"
# Compute allel frequencies
plink \
	--bfile qc-camgwas \
	--allow-no-sex \
	--freq \
	--out qc-camgwas

echo -e "\n### Now extract palindromic SNPs in R for subsequent exclusion ###"
R CMD BATCH palindromicsnps.R

echo -e "\n### Check Strand using the Wrayner perl script ###"
./checkstrand.sh

echo -e "\n### Update Run-plink.sh file to remove palindromic SNPs ###"
echo "plink --bfile qc-camgwas --allow-no-sex --exclude at-cg.snps --make-bed --out TEMP0" > TEMP.file
echo "plink --bfile TEMP0 --exclude Exclude-qc-camgwas-1000G.txt --make-bed --out TEMP1" >> TEMP.file
echo "plink --bfile TEMP1 --update-map Chromosome-qc-camgwas-1000G.txt --update-chr --make-bed --out TEMP2" >> TEMP.file
grep -v "TEMP1" Run-plink.sh >> TEMP.file
cp TEMP.file Run-plink.sh

echo -e "\n### Run Run-plink.sh to update the dataset ###"
./Run-plink.sh

echo -e "\nConverting Single Chromosome plink binary files to VCF files\n"
./plink2vcf.sh

echo -e "\n### Chechk VCF for errors using the checkVCF.py script ###"
./vcfcheck.sh
