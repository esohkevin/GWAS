#!/bin/bash

### Association tests including covariats to account for population structure

# With PC1, PC5 and PC9 as reported by glm to associate significantly with disease
plink \
        --bfile qc-camgwas \
        --covar ../popstruct/ps-data.mds \
        --covar-name C1 C5 C9 \
        --allow-no-sex \
        --autosome \
        --hide-covar \
        --logistic beta \
	--ci 0.95 \
        --out ps-qc-camgwasC1C5C9
cat ps-qc-camgwasC1C5C9.log >> all-ps-assoc.log

# With all PCs - Additive MOI
plink \
        --bfile qc-camgwas \
        --covar ../popstruct/ps-data.mds \
        --covar-name C1 C2 C3 C4 C5 C6 C7 C8 C9 C10 \
        --allow-no-sex \
        --autosome \
        --hide-covar \
        --logistic beta \
	--ci 0.95 \
        --out ps-qc-camgwasC1-C10-add
cat ps-qc-camgwasC1-C10-add.log >> all-ps-assoc.log

# With all PCs and different MOI
plink \
        --bfile qc-camgwas \
        --covar ../popstruct/ps-data.mds \
        --covar-name C1 C2 C3 C4 C5 C6 C7 C8 C9 C10 \
        --allow-no-sex \
        --autosome \
        --hide-covar \
        --model \
        --out ps-qc-camgwasC1-C10-model
cat ps-qc-camgwasC1-C10-model.log >> all-ps-assoc.log

# With all PCs and hethom MOI
plink \
        --bfile qc-camgwas \
        --covar ../popstruct/ps-data.mds \
        --covar-name C1 C2 C3 C4 C5 C6 C7 C8 C9 C10 \
        --allow-no-sex \
        --autosome \
        --hide-covar \
        --logistic hethom \
	--ci 0.95 \
        --out ps-qc-camgwasC1-C10-hethom
cat ps-qc-camgwasC1-C10-hethom.log >> all-ps-assoc.log

# With all PCs and Recessive MOI
plink \
        --bfile qc-camgwas \
        --covar ../popstruct/ps-data.mds \
        --covar-name C1 C2 C3 C4 C5 C6 C7 C8 C9 C10 \
        --allow-no-sex \
        --autosome \
        --hide-covar \
        --logistic recessive \
        --ci 0.95 \
        --out ps-qc-camgwasC1-C10-rec
cat ps-qc-camgwasC1-C10-rec.log >> all-ps-assoc.log

echo -e "###################### Post-PS Start ####################\n" >> snpsofinterest.txt
echo "###################### ADD C1C5C9 ###########################" >> snpsofinterest.txt
awk '$12<1e-05' ps-qc-camgwasC1C5C9.assoc.logistic >> snpsofinterest.txt
echo "###################### C1-C10 ADD ###########################" >> snpsofinterest.txt
awk '$12<1e-05' ps-qc-camgwasC1-C10-add.assoc.logistic >> snpsofinterest.txt
echo "###################### C1-C10 HETHOM ###########################" >> snpsofinterest.txt
awk '$12<1e-05' ps-qc-camgwasC1-C10-hethom.assoc.logistic >> snpsofinterest.txt
echo "###################### C1-C10 REC ###########################" >> snpsofinterest.txt
awk '$12<1e-05' ps-qc-camgwasC1-C10-rec.assoc.logistic >> snpsofinterest.txt
echo "###################### MODEL ###########################" >> snpsofinterest.txt
awk '$10<1e-05' ps-qc-camgwasC1-C10-model.model >> snpsofinterest.txt
echo -e "\n###################### Post-PS End #####################\n" >> snpsofinterest.txt


#########################################################################
#                        Plot Association in R                          #
#########################################################################
echo -e "\nNow generating association plots in R. Please wait..."

echo "#################### PS R #####################" >> snpsofinterest.txt
Rscript post-ps-assoc.R >> snpsofinterest.txt
echo "#################### PS R #####################" >> snpsofinterest.txt

# Filter association results to obtain SNPs with p-val 1e-5
#for i in ps*-qc-camgwas.assoc.logistic; 
#do 
#	head -1 ${i} > ${i/-qc-camgwas.assoc.logistic/-assoc.results}; 
#	awk '$9<1e-5' ${i} >> ${i/-qc-camgwas.assoc.logistic/-assoc.results}; 
#done
