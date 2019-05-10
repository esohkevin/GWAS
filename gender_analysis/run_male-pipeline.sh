#!/bin/bash
# Paths
popstruct="$HOME/GWAS/Git/GWAS/popstruct"
assocResults="$HOME/GWAS/Git/GWAS/assoc_results"
samples="$HOME/GWAS/Git/GWAS/samples"
analysis="$HOME/GWAS/Git/GWAS/analysis"

# Get sample IDs for FO ethnic group to exclude from analysis
grep "FO"  $samples/eth-cluster-all.txt > exclude_ethn.txt
cut -f1,2 -d' ' $samples/exclude_ethn.txt > $samples/exclude_fo.txt

# Run several association tests on the different sample sets
# Additive
plink \
	--bfile $analysis/qc-camgwas-eig-corrected-males \
	--remove $samples/exclude_fo.txt \
	--logistic \
	--ci 0.95 \
	--covar $popstruct/eig-camgwas.pca \
	--covar-name C1-C20 \
	--out males-add

# Recessive
plink \
        --bfile $analysis/qc-camgwas-eig-corrected-males \
        --remove $samples/exclude_fo.txt \
        --logistic recessive \
        --ci 0.95 \
        --covar $popstruct/eig-camgwas.pca \
        --covar-name C1-C20 \
        --out males-rec

# Dominant
plink \
        --bfile $analysis/qc-camgwas-eig-corrected-males \
        --remove $samples/exclude_fo.txt \
        --logistic dominant \
        --ci 0.95 \
        --covar $popstruct/eig-camgwas.pca \
        --covar-name C1-C20 \
        --out males-dom

# hethom
plink \
        --bfile $analysis/qc-camgwas-eig-corrected-males \
        --remove $samples/exclude_fo.txt \
        --logistic hethom \
        --ci 0.95 \
        --covar $popstruct/eig-camgwas.pca \
        --covar-name C1-C20 \
        --out males-hethom

# model
plink \
        --bfile $analysis/qc-camgwas-eig-corrected-males \
        --remove $samples/exclude_fo.txt \
        --model \
        --ci 0.95 \
        --covar $popstruct/eig-camgwas.pca \
        --covar-name C1-C20 \
        --out males

echo "################################################ ADD ############################################# " > males-snpsofinterest.txt
head -1 males-add.assoc.logistic >> males-snpsofinterest.txt; awk '$12<1e-05' males-add.assoc.logistic | awk '$5=="ADD"' >> males-snpsofinterest.txt 
echo "################################################ REC ############################################# " >> males-snpsofinterest.txt
head -1 males-rec.assoc.logistic >> males-snpsofinterest.txt; awk '$12<1e-05' males-rec.assoc.logistic | awk '$5=="REC"' >> males-snpsofinterest.txt 
echo "################################################ DOM ############################################# " >> males-snpsofinterest.txt
head -1 males-dom.assoc.logistic >> males-snpsofinterest.txt; awk '$12<1e-05' males-dom.assoc.logistic | awk '$5=="DOM"' >> males-snpsofinterest.txt 
echo "################################################ HETHOM ############################################# " >> males-snpsofinterest.txt
head -1 males-hethom.assoc.logistic >> males-snpsofinterest.txt; awk '$12<1e-05' males-hethom.assoc.logistic | awk '$5=="HET"|| $5=="HOM"' >> males-snpsofinterest.txt
echo "################################################ MODEL ############################################# " >> males-snpsofinterest.txt
head -1 males.model >> males-snpsofinterest.txt; awk '$10<1e-05' males.model >> males-snpsofinterest.txt
