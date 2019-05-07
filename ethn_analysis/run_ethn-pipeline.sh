#!/bin/bash

# Get sample IDs for BA and SB ethnic groups
grep "BA"  ../samples/eth-cluster-all.txt > include_ethn.txt
grep "SB"  ../samples/eth-cluster-all.txt >> include_ethn.txt
cut -f1,2 -d' ' include_ethn.txt > include_bantu-semibantu.txt

# Run several association tests on the different sample sets
# Additive
plink \
	--bfile ../analysis/qc-camgwas-updated \
	--keep include_bantu-semibantu.txt \
	--logistic \
	--ci 0.95 \
	--covar ../popstruct/eig-camgwas.pca \
	--covar-name C1-C20 \
	--out bantu-semib-add

# Recessive
plink \
        --bfile ../analysis/qc-camgwas-updated \
        --keep include_bantu-semibantu.txt \
        --logistic recessive \
        --ci 0.95 \
        --covar ../popstruct/eig-camgwas.pca \
        --covar-name C1-C20 \
        --out bantu-semib-rec

# Dominant
plink \
        --bfile ../analysis/qc-camgwas-updated \
        --keep include_bantu-semibantu.txt \
        --logistic dominant \
        --ci 0.95 \
        --covar ../popstruct/eig-camgwas.pca \
        --covar-name C1-C20 \
        --out bantu-semib-dom

# hethom
plink \
        --bfile ../analysis/qc-camgwas-updated \
        --keep include_bantu-semibantu.txt \
        --logistic hethom \
        --ci 0.95 \
        --covar ../popstruct/eig-camgwas.pca \
        --covar-name C1-C20 \
        --out bantu-semib-hethom

# model
plink \
        --bfile ../analysis/qc-camgwas-updated \
        --keep include_bantu-semibantu.txt \
        --model \
        --ci 0.95 \
        --covar ../popstruct/eig-camgwas.pca \
        --covar-name C1-C20 \
        --out bantu-semib

echo "################################################ ADD ############################################# " > bantu-semib-snpsofinterest.txt
head -1 bantu-semib-add.assoc.logistic >> bantu-semib-snpsofinterest.txt; awk '$12<1e-05' bantu-semib-add.assoc.logistic | awk '$5=="ADD"' >> bantu-semib-snpsofinterest.txt
echo "################################################ REC ############################################# " >> bantu-semib-snpsofinterest.txt
head -1 bantu-semib-rec.assoc.logistic >> bantu-semib-snpsofinterest.txt; awk '$12<1e-05' bantu-semib-rec.assoc.logistic | awk '$5=="REC"' >> bantu-semib-snpsofinterest.txt
echo "################################################ DOM ############################################# " >> bantu-semib-snpsofinterest.txt
head -1 bantu-semib-dom.assoc.logistic >> bantu-semib-snpsofinterest.txt; awk '$12<1e-05' bantu-semib-dom.assoc.logistic | awk '$5=="DOM"' >> bantu-semib-snpsofinterest.txt
echo "################################################ HETHOM ############################################# " >> bantu-semib-snpsofinterest.txt
head -1 bantu-semib-hethom.assoc.logistic >> bantu-semib-snpsofinterest.txt; awk '$12<1e-05' bantu-semib-hethom.assoc.logistic | awk '$5=="HET"|| $5=="HOM"' >> bantu-semib-snpsofinterest.txt
echo "################################################ MODEL ############################################# " >> bantu-semib-snpsofinterest.txt
head -1 bantu-semib.model >> bantu-semib-snpsofinterest.txt; awk '$10<1e-05' bantu-semib.model >> bantu-semib-snpsofinterest.txt
