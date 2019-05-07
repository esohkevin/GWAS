#!/bin/bash

# Get sample IDs for FO ethnic group to exclude from analysis
grep "FO"  ../samples/eth-cluster-all.txt > exclude_ethn.txt
cut -f1,2 -d' ' exclude_ethn.txt > exclude_fo.txt

# Run several association tests on the different sample sets
# Additive
plink \
	--bfile qc-camgwas-males \
	--remove exclude_fo.txt \
	--logistic \
	--ci 0.95 \
	--covar ../popstruct/eig-camgwas.pca \
	--covar-name C1-C20 \
	--out males-add
echo "################################################ ADD ############################################# " > males-snpsofinterest.txt
awk '$12<1e-05' males-add.assoc.logistic | awk '$5=="ADD"' >> females-snpsofinterest.txt

# Recessive
plink \
        --bfile qc-camgwas-males \
        --remove exclude_fo.txt \
        --logistic recessive \
        --ci 0.95 \
        --covar ../popstruct/eig-camgwas.pca \
        --covar-name C1-C20 \
        --out males-rec
echo "################################################ REC ############################################# " >> males-snpsofinterest.txt
awk '$12<1e-05' males-rec.assoc.logistic >> females-snpsofinterest.txt

# Dominant
plink \
        --bfile qc-camgwas-males \
        --remove exclude_fo.txt \
        --logistic dominant \
        --ci 0.95 \
        --covar ../popstruct/eig-camgwas.pca \
        --covar-name C1-C20 \
        --out males-dom
echo "################################################ DOM ############################################# " >> males-snpsofinterest.txt
awk '$12<1e-05' males-dom.assoc.logistic >> females-snpsofinterest.txt

# hethom
plink \
        --bfile qc-camgwas-males \
        --remove exclude_fo.txt \
        --logistic hethom \
        --ci 0.95 \
        --covar ../popstruct/eig-camgwas.pca \
        --covar-name C1-C20 \
        --out males-hethom
echo "################################################ HETHOM ############################################# " >> males-snpsofinterest.txt
awk '$12<1e-05' males-hethom.assoc.logistic >> females-snpsofinterest.txt

# model
plink \
        --bfile qc-camgwas-males \
        --remove exclude_fo.txt \
        --model \
        --ci 0.95 \
        --covar ../popstruct/eig-camgwas.pca \
        --covar-name C1-C20 \
        --out males
echo "################################################ MODEL ############################################# " >> males-snpsofinterest.txt
awk '$10<1e-05' males.model >> females-snpsofinterest.txt


