#!/bin/bash

# Exclude the Foulbe ethnic group
# Run Association test with adjustment to assess the genomic control inflation factor (lambda) 
plink1.9 \
        --bfile ../analysis/qc-camgwas-updated \
        --autosome \
	--remove ../gender_analysis/exclude_fo.txt \
        --allow-no-sex \
        --assoc \
        --adjust \
        --out qc-camgwas
cat qc-camgwas.log >> all-assoc.log

# Run Association test on QCed data (logistic beta) - Additive MOI
plink1.9 \
        --bfile ../analysis/qc-camgwas-updated \
        --autosome \
	--remove ../gender_analysis/exclude_fo.txt \
        --allow-no-sex \
        --logistic beta \
        --set-hh-missing \
        --ci 0.95 \
        --out qc-camgwas-add
cat qc-camgwas-add.log >> all-assoc.log

# Run Association test on QCed data (logistic beta) - Dominant MOI
plink1.9 \
        --bfile ../analysis/qc-camgwas-updated \
        --autosome \
	--remove ../gender_analysis/exclude_fo.txt \
        --allow-no-sex \
        --logistic dominant \
        --set-hh-missing \
        --ci 0.95 \
        --out qc-camgwas-dom
cat qc-camgwas-dom.log >> all-assoc.log

# Run Association test on QCed data (logistic beta) - Recessive MOI
plink1.9 \
        --bfile ../analysis/qc-camgwas-updated \
        --autosome \
	--remove ../gender_analysis/exclude_fo.txt \
        --allow-no-sex \
        --logistic recessive \
        --set-hh-missing \
        --ci 0.95 \
        --out qc-camgwas-rec
cat qc-camgwas-rec.log >> all-assoc.log

# Run Association test on QCed data (logistic beta) - hethom MOI
plink1.9 \
        --bfile ../analysis/qc-camgwas-updated \
        --autosome \
	--remove ../gender_analysis/exclude_fo.txt \
        --allow-no-sex \
        --logistic hethom \
        --set-hh-missing \
        --ci 0.95 \
        --out qc-camgwas-hethom
cat qc-camgwas-hethom.log >> all-assoc.log

# Run Association test on QCed data (logistic beta) - Model
plink1.9 \
        --bfile ../analysis/qc-camgwas-updated \
        --autosome \
	--remove ../gender_analysis/exclude_fo.txt \
        --allow-no-sex \
        --model \
        --set-hh-missing \
        --out qc-camgwas-model
cat qc-camgwas-model.log >> all-assoc.log


# Run Association tests fitting different X-chromosome models
# Add sex as a covariate on X chr
#s=`seq 1 1 3`
#for i in $s
#do
#        plink1.9 \
#                --bfile qc-camgwas \
#                --xchr-model $i \
#                --allow-no-sex \
#                --logistic beta \
#                --ci 0.95 \
#                --set-hh-missing \
#                --out xchr$i
#cat xchr$i.log >> all.log
#done

#plink1.9 \
#        --bfile qc-camgwas \
#        --autosome-xy \
#        --allow-no-sex \
#        --assoc \
#        --adjust \
#        --set-hh-missing \
#        --out autopseudo
#cat autopseudo.log >> all.log
echo -e "###################### Post-QC Start ####################\n" > snpsofinterest.txt
echo "###################### HETHOM ###########################" >> snpsofinterest.txt
head -1 qc-camgwas-hethom.assoc.logistic >> snpsofinterest.txt
awk '$12<1e-04' qc-camgwas-hethom.assoc.logistic >> snpsofinterest.txt
echo "###################### ADD ###########################" >> snpsofinterest.txt
head -1 qc-camgwas-add.assoc.logistic >> snpsofinterest.txt
awk '$12<1e-04' qc-camgwas-add.assoc.logistic >> snpsofinterest.txt
echo "###################### DOM ###########################" >> snpsofinterest.txt
head -1 qc-camgwas-dom.assoc.logistic >> snpsofinterest.txt
awk '$12<1e-04' qc-camgwas-dom.assoc.logistic >> snpsofinterest.txt
echo "###################### REC ###########################" >> snpsofinterest.txt
head -1 qc-camgwas-rec.assoc.logistic >> snpsofinterest.txt
awk '$12<1e-04' qc-camgwas-rec.assoc.logistic >> snpsofinterest.txt
echo "###################### MODEL ###########################" >> snpsofinterest.txt
head -1 qc-camgwas-model.model >> snpsofinterest.txt
awk '$10<1e-04' qc-camgwas-model.model >> snpsofinterest.txt
echo -e "\n###################### Post-QC End #####################\n" >> snpsofinterest.txt

echo """
#################################################################
#		Run Post-QC Associations Plots			#
#################################################################
	Running Post-QC Association Plot in R

	Please check the 'snpsofinterest.txt' file for associations
	with P-val < 1e-04 (0.00001)
"""

#echo "#################### QC R #####################" >> snpsofinterest.txt
#Rscript post-qc-assoc.R >> snpsofinterest.txt
#echo "#################### QC R #####################" >> snpsofinterest.txt

