#!/bin/bash

# Get sample IDs for FO ethnic group to exclude from analysis
grep "FO"  ../samples/eth-cluster-all.txt > exclude_ethn.txt
cut -f1,2 -d' ' exclude_ethn.txt > exclude_fo.txt

# Run several association tests on the different sample sets
# Additive
plink \
	--bfile qc-camgwas-females \
	--remove exclude_fo.txt \
	--logistic \
	--ci 0.95 \
	--covar ../popstruct/eig-camgwas.pca \
	--covar-name C1-C20 \
	--out females-add
echo "################################################ ADD ############################################# " > females-snpsofinterest.txt
awk '$12<1e-05' females-add.assoc.logistic | awk '$5=="ADD"' >> females-snpsofinterest.txt

# Recessive
plink \
        --bfile qc-camgwas-females \
        --remove exclude_fo.txt \
        --logistic recessive \
        --ci 0.95 \
        --covar ../popstruct/eig-camgwas.pca \
        --covar-name C1-C20 \
        --out females-rec
echo "################################################ REC ############################################# " >> females-snpsofinterest.txt
awk '$12<1e-05' females-rec.assoc.logistic >> females-snpsofinterest.txt

# Dominant
plink \
        --bfile qc-camgwas-females \
        --remove exclude_fo.txt \
        --logistic dominant \
        --ci 0.95 \
        --covar ../popstruct/eig-camgwas.pca \
        --covar-name C1-C20 \
        --out females-dom
echo "################################################ DOM ############################################# " >> females-snpsofinterest.txt
awk '$12<1e-05' females-dom.assoc.logistic >> females-snpsofinterest.txt

# hethom
plink \
        --bfile qc-camgwas-females \
        --remove exclude_fo.txt \
        --logistic hethom \
        --ci 0.95 \
        --covar ../popstruct/eig-camgwas.pca \
        --covar-name C1-C20 \
        --out females-hethom
echo "################################################ HETHOM ############################################# " >> females-snpsofinterest.txt
awk '$12<1e-05' females-hethom.assoc.logistic >> females-snpsofinterest.txt

# model
plink \
        --bfile qc-camgwas-females \
        --remove exclude_fo.txt \
        --model \
        --ci 0.95 \
        --covar ../popstruct/eig-camgwas.pca \
        --covar-name C1-C20 \
        --out females
echo "################################################ MODEL ############################################# " >> females-snpsofinterest.txt
awk '$10<1e-05' females.model >> females-snpsofinterest.txt


