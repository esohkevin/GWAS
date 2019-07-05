#!/usr/bin/env bash

cd ../;
baseDir=`pwd`
cd -;
analysis="${baseDir}/analysis/"
kgp="${baseDir}/phase/1000GP_Phase3/"
eig="${baseDir}/popstruct/eig/EIGENSTRAT/"
eigstruct="${baseDir}/popstruct/eig/"

#echo "######################## Extract Palimcromic SNPs and prepare chromosomes for imputation services ########################"
## Compute allel frequencies
#plink \
#	--bfile qc-camgwas-eig-corr \
#	--allow-no-sex \
#	--freq \
#	--out qc-camgwas-eig-corr


#
#echo -e "\n####################### Now extract palindromic SNPs in R for subsequent exclusion #####################"
#R CMD BATCH palindromicsnps.R
#
#echo -e "\n#################### Check Strand using the Wrayner perl script #############################"
#./checkstrand.sh
#
######################## Add command line to remove at-cg SNPs ###################################
plink --bfile qc-camgwas-eig-corr --exclude at-cg.snps --make-bed --out TEMP0
plink --bfile TEMP0 --allow-no-sex --exclude Exclude-qc-camgwas-eig-corr-1000G.txt --make-bed --out TEMP1
plink --bfile TEMP1 --update-chr Chromosome-qc-camgwas-eig-corr-1000G.txt 2 1 --make-bed --out TEMP2
plink --bfile TEMP2 --update-map Position-qc-camgwas-eig-corr-1000G.txt 2 1 --make-bed --out TEMP3
plink --bfile TEMP3 --flip Strand-Flip-qc-camgwas-eig-corr-1000G.txt --make-bed --out TEMP4
plink2 --bfile TEMP4 --ref-allele force refSites.txt 4 1 --make-bed --out qc-camgwas-updated
#plink --bfile TEMP5 --update-name ID-qc-camgwas-eig-corr-1000G.txt 2 1 --keep-allele-order --make-bed --out qc-camgwas-updated

echo -e "\n################# Converting plink binary files to VCF ####################\n"
#./plink2vcf.sh

plink --bfile qc-camgwas-updated --recode vcf-fid bgz --real-ref-alleles --keep-allele-order --out qc-camgwas-updated

tabix -f -p vcf qc-camgwas-updated.vcf.gz
bcftools sort qc-camgwas-updated.vcf.gz -Oz -o qc-camgwas-updated.vcf.gz
#bcftools index qc-camgwas-updated.vcf.gz

#mv qc-camgwas-updated.vcf.gz ../phase/

#echo -e "\n######################## Chechk VCF for errors using the checkVCF.py script ########################"
#./vcfcheck.sh

################################# Remove Irrelevant Files ####################################
#rm qc-camgwas-eig-corr-updated-chr*.* 
rm TEMP*
