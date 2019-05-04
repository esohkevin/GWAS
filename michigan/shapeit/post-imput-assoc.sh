#!/bin/bash

# Run Post Imputation Associations with Covars to account for population structure
# With PC1 and PC2
plink \
        --bfile merge.filtered-updated \
        --covar ../../popstruct/evecData.txt \
        --covar-name C1 C2 C3 C4 C5 C6 C7 C8 C9 C10 \
        --autosome \
	--keep ../../popstruct/evecData.ids \
        --allow-no-sex \
        --hide-covar \
        --logistic recessive \
	--ci 0.95 \
        --out post-impc1-10-rec
#cat post-impc1c2.log >> post-imp-assoc-all.log

# With PC1, PC5 and PC9 as reported by glm to associate significantly with disease
plink \
        --bfile merge.filtered-updated \
        --covar ../../popstruct/evecData.txt \
	--keep ../../popstruct/evecData.ids \
        --covar-name C1 C4 C5 \
        --allow-no-sex \
        --autosome \
        --hide-covar \
        --logistic \
        --out post-impc1c4c5
#cat post-impc1c5c9.log >> post-imp-assoc-all.log

# With all PCs
plink \
        --bfile merge.filtered-updated \
        --covar ../../popstruct/evecData.txt \
        --keep ../../popstruct/evecData.ids \
	--covar-name C1 C2 C3 C4 C5 C6 C7 C8 C9 C10 \
        --allow-no-sex \
        --autosome \
        --hide-covar \
        --logistic \
	--ci 0.95 \
        --out post-impc1-c10-add
#cat post-impc1-c10.log >> post-imp-assoc-all.log

# With all PCs and different MOI
plink \
        --bfile merge.filtered-updated \
	--covar ../../popstruct/evecData.txt \
        --keep ../../popstruct/evecData.ids \
        --covar-name C1 C2 C3 C4 C5 C6 C7 C8 C9 C10 \
        --allow-no-sex \
        --autosome \
        --hide-covar \
        --model \
        --out post-impc1-c10-model
#cat post-impc1-c10-model.log >> post-imp-assoc-all.log

# With all PCs and hethom MOI
plink \
        --bfile merge.filtered-updated \
	--covar ../../popstruct/evecData.txt \
        --keep ../../popstruct/evecData.ids \
        --covar-name C1 C2 C3 C4 C5 C6 C7 C8 C9 C10 \
        --allow-no-sex \
        --autosome \
        --hide-covar \
        --logistic hethom \
        --out post-impc1-c10-hethom
#cat post-impc1-c10-hethom.log >> post-imp-assoc-all.log

plink \
        --bfile merge.filtered-updated \
        --covar ../../popstruct/evecData.txt \
        --keep ../../popstruct/evecData.ids \
        --covar-name C1 C2 C3 C4 C5 C6 C7 C8 C9 C10 \
        --allow-no-sex \
        --autosome \
        --hide-covar \
        --logistic dominant \
        --ci 0.95 \
        --out post-impc1-c10-dom

echo -e "######################################### Post-Imputation Start ########################################\n" > post-imp-snpsofinterest.txt
echo "############################################### HETHOM ##############################################" >> post-imp-snpsofinterest.txt
awk '$12<1e-05' post-impc1-c10-hethom.assoc.logistic >> post-imp-snpsofinterest.txt
echo "############################################### ADD ######################################################" >> post-imp-snpsofinterest.txt
awk '$12<1e-05' post-impc1-c10-add.assoc.logistic >> post-imp-snpsofinterest.txt
echo "######################################################## ADD C1C4C5 ############################################" >> post-imp-snpsofinterest.txt
awk '$12<1e-05' post-impc1c4c5-add.assoc.logistic >> post-imp-snpsofinterest.txt
echo "########################################################## DOM ############################################" >> post-imp-snpsofinterest.txt
awk '$12<1e-05' post-impc1-c10-dom.assoc.logistic >> post-imp-snpsofinterest.txt
echo "################################################# REC ###########################################################" >> post-imp-snpsofinterest.txt
awk '$12<1e-05' post-impc1-c10-rec.assoc.logistic >> post-imp-snpsofinterest.txt
echo "########################################################### MODEL ################################################" >> post-imp-snpsofinterest.txt
awk '$10<1e-05' post-impc1-c10-model.model >> post-imp-snpsofinterest.txt
echo -e "\n################################################### Post-Imputation End ###############################################\n" >> post-imp-snpsofinterest.txt

#########################################################################
#                        Plot Association in R                          #
#########################################################################

# Filter association results to obtain SNPs with p-val 1e-5
#for i in ps*-post-imp.assoc.logistic; 
#do 
#	head -1 ${i} > ${i/-post-imp.assoc.logistic/-assoc.results}; 
#	awk '$9<1e-5' ${i} >> ${i/-post-imp.assoc.logistic/-assoc.results}; 
#done

# Produce manhattan plots in R
#R CMD BATCH post-imput-assoc.R

#mv *.png ../../images/

