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

echo -e "\n### Now extract palindromic SNPs in R for subsequent exclusion ###"
R CMD BATCH palindromicsnps.R

echo -e "\n### Check Strand using the Wrayner perl script ###"
./checkstrand.sh

####################### Fix IDs by reducing the length before Updating ##########################
cut -f1,2 -d':' ID-qc-camgwas-1000G.txt > id1.txt
mv id1.txt ID-qc-camgwas-1000G.txt 


####################### Add command line to remove at-cg SNPs ###################################
echo -e "\n### Update Run-plink.sh file to remove palindromic SNPs ###"
echo "plink --bfile qc-camgwas --allow-no-sex --exclude at-cg.snps --make-bed --out TEMP0" > TEMP.file
echo "plink --bfile TEMP0 --exclude Exclude-qc-camgwas-1000G.txt --make-bed --out TEMP1" >> TEMP.file
echo "plink --bfile TEMP1 --update-map Chromosome-qc-camgwas-1000G.txt --update-chr --make-bed --out TEMP2" >> TEMP.file
grep -v "TEMP1" Run-plink.sh >> TEMP.file
cp TEMP.file Run-plink.sh

############## Extract command line to update single chrmosomes only from Run-Plink.sh  ########
echo "plink --bfile qc-camgwas-updated --update-name ID-qc-camgwas-1000G.txt 2 1 --make-bed --out qc-camgwas-updated" > splitByChrom.sh
tail -24 Run-plink.sh | head -23 >> splitByChrom.sh; chmod 755 splitByChrom.sh

################### Extract command line to update the combined chr file only ###################
head -6 Run-plink.sh > TEMP1
tail -1 Run-plink.sh > TEMP2
cat TEMP1 TEMP2 > Run-plink.sh

########################### Now update the IDs in the combined file #############################
echo -e "\n### Run Run-plink.sh to update the dataset ###"
./Run-plink.sh

###################### Now split the updated combined file into single chrs #####################
./splitByChrom.sh

echo -e "\nConverting Single Chromosome plink binary files to VCF files\n"
./plink2vcf.sh

echo -e "\n### Chechk VCF for errors using the checkVCF.py script ###"
./vcfcheck.sh

################################# Remove Irrelevant Files ####################################
rm qc-camgwas-updated-chr*.*
