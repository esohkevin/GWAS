#!/usr/bin/env bash

cd ../;
baseDir=`pwd`
cd -;
analysis="${baseDir}/analysis/"
kgp="${baseDir}/phase/1000GP_Phase3/"
eig="${baseDir}/popstruct/eig/EIGENSTRAT/"
eigstruct="${baseDir}/popstruct/eig/"

echo "### Extract Palimcromic SNPs and prepare chromosomes for imputation services ###"
# Compute allel frequencies
plink \
	--bfile qc-camgwas \
	--allow-no-sex \
	--freq \
	--out qc-camgwas
cat qc-camgwas.log > imputPrep.log

echo -e "\n### Now extract palindromic SNPs in R for subsequent exclusion ###"
R CMD BATCH palindromicsnps.R

####################### Add command line to remove at-cg SNPs ###################################
echo -e "\n### Update Run-plink.sh file to remove palindromic SNPs ###"
plink \
        --bfile qc-camgwas \
        --allow-no-sex \
        --exclude at-cg.snps \
        --make-bed \
        --out qc-camgwas
cat qc-camgwas.log >> imputPrep.log

echo -e "\n### Check Strand using the Wrayner perl script ###"
./checkstrand.sh

##################################### Edit the Run-plink.sh file ################################
head -5 Run-plink.sh > temp1
tail -1 Run-plink.sh > temp2
cat temp1 temp2 > Run-plink1.sh
chmod 755 Run-plink1.sh
rm temp*

########################### Now update the IDs in the combined file ############################
echo -e "\n### Run Run-plink.sh to update the dataset ###"
./Run-plink1.sh
cat qc-camgwas-updated.log >> imputPrep.log

################################### Update IDs #################################################
#grep "rs" ../tmp/ID-qc-camgwas-1000G.txt | cut -f1 -d':' > updateName.txt
cut -f1,2 -d':' ID-qc-camgwas-1000G.txt > updateName.txt
echo "plink --bfile qc-camgwas-updated --reference-allele Force-Allele1-qc-camgwas-1000G.txt --update-name updateName.txt 2 1 --make-bed --out qc-camgwas-updated" > Run-plink2.sh

tail -24 Run-plink.sh | \
	head -23 >> Run-plink2.sh
chmod 755 Run-plink2.sh
./Run-plink2.sh
cat qc-camgwas-updated.log >> imputPrep.log

rm qc-camgwas-updated.bim~ qc-camgwas-updated.bed~ qc-camgwas-updated.fam~ qc-camgwas.bed~ qc-camgwas.bim~ qc-camgwas.fam~
###############################################################################################
echo -e "\nConverting Single Chromosome plink binary files to VCF files\n"
./plink2vcf.sh

echo -e "\n### Chechk VCF for errors using the checkVCF.py script ###"
./vcfcheck.sh

################################# Remove Irrelevant Files ####################################
rm qc-camgwas-updated-chr*.*
