#!/bin/bash

### Association tests including covariats to account for population structure

# With PC1, PC4, PC5 and C19 as reported by eigenstrat to associate significantly with disease
plink \
        --bfile ../analysis/qc-camgwas-updated \
        --covar ../popstruct/eig-camgwas.pca \
        --covar-name C1 C4 C5 C19 \
	--keep ../popstruct/eig-camgwas.ids \
        --allow-no-sex \
        --autosome \
	--remove ../gender_analysis/exclude_fo.txt \
        --hide-covar \
        --logistic beta \
	--ci 0.95 \
        --out eig-qc-camgwasC1C4C5C19
cat eig-qc-camgwasC1C4C5C19.log >> all-eig-assoc.log

# With all PCs - Additive MOI
plink \
        --bfile ../analysis/qc-camgwas-updated \
        --covar ../popstruct/eig-camgwas.pca \
        --covar-name C1-C20 \
        --allow-no-sex \
	--remove ../gender_analysis/exclude_fo.txt \
        --autosome \
	--keep ../popstruct/eig-camgwas.ids \
        --hide-covar \
        --logistic \
	--ci 0.95 \
        --out eig-qc-camgwasC1-C20-add
cat eig-qc-camgwasC1-C20-add.log >> all-eig-assoc.log

# With all PCs and Dominant MOI
plink \
        --bfile ../analysis/qc-camgwas-updated \
        --covar ../popstruct/eig-camgwas.pca \
        --covar-name C1-C20 \
        --allow-no-sex \
        --autosome \
	--remove ../gender_analysis/exclude_fo.txt \
        --keep ../popstruct/eig-camgwas.ids \
        --hide-covar \
        --logistic dominant \
        --ci 0.95 \
        --out eig-qc-camgwasC1-C20-dom
cat eig-qc-camgwasC1-C20-dom.log >> all-eig-assoc.log

# With all PCs and different MOI
plink \
        --bfile ../analysis/qc-camgwas-updated \
        --covar ../popstruct/eig-camgwas.pca \
        --covar-name C1-C20 \
	--allow-no-sex \
        --autosome \
        --hide-covar \
	--remove ../gender_analysis/exclude_fo.txt \
	--keep ../popstruct/eig-camgwas.ids \
        --model \
        --out eig-qc-camgwasC1-C20-model
cat eig-qc-camgwasC1-C20-model.log >> all-eig-assoc.log

# With all PCs and hethom MOI
plink \
        --bfile ../analysis/qc-camgwas-updated \
        --covar ../popstruct/eig-camgwas.pca \
        --covar-name C1-C20 \
        --allow-no-sex \
        --autosome \
        --hide-covar \
	--remove ../gender_analysis/exclude_fo.txt \
	--keep ../popstruct/eig-camgwas.ids \
        --logistic hethom \
	--ci 0.95 \
        --out eig-qc-camgwasC1-C20-hethom
cat eig-qc-camgwasC1-C20-hethom.log >> all-eig-assoc.log

# With all PCs and Recessive MOI
plink \
        --bfile ../analysis/qc-camgwas-updated \
        --covar ../popstruct/eig-camgwas.pca \
        --covar-name C1-C20 \
        --allow-no-sex \
        --autosome \
	--keep ../popstruct/eig-camgwas.ids \
        --hide-covar \
        --logistic recessive \
        --ci 0.95 \
        --out eig-qc-camgwasC1-C20-rec
cat eig-qc-camgwasC1-C20-rec.log >> all-eig-assoc.log

echo -e "###################### Post-EIG Start ####################\n" >> snpsofinterest.txt
echo "###################### ADD C1C4C5C19 ###########################" >> snpsofinterest.txt
head -1 eig-qc-camgwasC1C4C5C19.assoc.logistic >> snpsofinterest.txt
awk '$12<1e-04' eig-qc-camgwasC1C4C5C19.assoc.logistic >> snpsofinterest.txt
echo "###################### C1-C20 ADD ###########################" >> snpsofinterest.txt
head -1 eig-qc-camgwasC1-C20-add.assoc.logistic >> snpsofinterest.txt
awk '$12<1e-04' eig-qc-camgwasC1-C20-add.assoc.logistic >> snpsofinterest.txt
echo "###################### C1-C20 HETHOM ###########################" >> snpsofinterest.txt
head -1 eig-qc-camgwasC1-C20-hethom.assoc.logistic >> snpsofinterest.txt
awk '$12<1e-04' eig-qc-camgwasC1-C20-hethom.assoc.logistic >> snpsofinterest.txt
echo "###################### C1-C20 REC ###########################" >> snpsofinterest.txt
head -1 eig-qc-camgwasC1-C20-rec.assoc.logistic >> snpsofinterest.txt
awk '$12<1e-04' eig-qc-camgwasC1-C20-rec.assoc.logistic >> snpsofinterest.txt
echo "###################### C1-C20 DOM ###########################" >> snpsofinterest.txt
head -1 eig-qc-camgwasC1-C20-dom.assoc.logistic >> snpsofinterest.txt
awk '$12<1e-04' eig-qc-camgwasC1-C20-dom.assoc.logistic >> snpsofinterest.txt
echo "###################### MODEL ###########################" >> snpsofinterest.txt
head -1 eig-qc-camgwasC1-C20-model.model >> snpsofinterest.txt
awk '$10<1e-04' eig-qc-camgwasC1-C20-model.model >> snpsofinterest.txt
echo -e "\n###################### Post-EIG End #####################\n" >> snpsofinterest.txt

#########################################################################
#                        Plot Association in R                          #
#########################################################################
#echo -e "\nNow generating association plots in R. Please wait..."

#echo "#################### EIG R #####################" >> snpsofinterest.txt
#Rscript post-eig-assoc.R >> snpsofinterest.txt
#echo "#################### EIG R #####################" >> snpsofinterest.txt

# Filter association results to obtain SNPs with p-val 1e-5
#for i in ps*-qc-camgwas.assoc.logistic; 
#do 
#	head -1 ${i} > ${i/-qc-camgwas.assoc.logistic/-assoc.results}; 
#	awk '$9<1e-5' ${i} >> ${i/-qc-camgwas.assoc.logistic/-assoc.results}; 
#done
