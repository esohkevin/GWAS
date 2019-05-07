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
echo "################################################ ADD ############################################# " > ethn-snpsofinterest.txt
awk '$12<1e-05' bantu-semib-add.assoc.logistic | awk '$5=="ADD"' >> ethn-snpsofinterest.txt

# Recessive
plink \
        --bfile ../analysis/qc-camgwas-updated \
        --keep include_bantu-semibantu.txt \
        --logistic recessive \
        --ci 0.95 \
        --covar ../popstruct/eig-camgwas.pca \
        --covar-name C1-C20 \
        --out bantu-semib-rec
echo "################################################ REC ############################################# " >> ethn-snpsofinterest.txt
awk '$12<1e-05' bantu-semib-rec.assoc.logistic >> ethn-snpsofinterest.txt

# Dominant
plink \
        --bfile ../analysis/qc-camgwas-updated \
        --keep include_bantu-semibantu.txt \
        --logistic dominant \
        --ci 0.95 \
        --covar ../popstruct/eig-camgwas.pca \
        --covar-name C1-C20 \
        --out bantu-semib-dom
echo "################################################ DOM ############################################# " >> ethn-snpsofinterest.txt
awk '$12<1e-05' bantu-semib-dom.assoc.logistic >> ethn-snpsofinterest.txt

# hethom
plink \
        --bfile ../analysis/qc-camgwas-updated \
        --keep include_bantu-semibantu.txt \
        --logistic hethom \
        --ci 0.95 \
        --covar ../popstruct/eig-camgwas.pca \
        --covar-name C1-C20 \
        --out bantu-semib-hethom
echo "################################################ HETHOM ############################################# " >> ethn-snpsofinterest.txt
awk '$12<1e-05' bantu-semib-hethom.assoc.logistic >> ethn-snpsofinterest.txt

# model
plink \
        --bfile ../analysis/qc-camgwas-updated \
        --keep include_bantu-semibantu.txt \
        --model \
        --ci 0.95 \
        --covar ../popstruct/eig-camgwas.pca \
        --covar-name C1-C20 \
        --out bantu-semib
echo "################################################ MODEL ############################################# " >> ethn-snpsofinterest.txt
awk '$10<1e-05' bantu-semib.model >> ethn-snpsofinterest.txt


