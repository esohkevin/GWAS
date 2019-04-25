#!/bin/bash

# Run Post Imputation Associations with Covars to account for population structure
# With PC1 and PC2
plink \
        --bfile merge.filtered-updated \
        --covar ../../popstruct/ps-data.mds \
        --covar-name C1 C2 \
        --autosome \
        --allow-no-sex \
        --hide-covar \
        --logistic \
        --out post-impc1c2
cat post-impc1c2.log >> post-imp-assoc-all.log

# With PC1, PC5 and PC9 as reported by glm to associate significantly with disease
plink \
        --bfile merge.filtered-updated \
        --covar ../../popstruct/ps-data.mds \
        --covar-name C1 C5 C9 \
        --allow-no-sex \
        --autosome \
        --hide-covar \
        --logistic \
        --out post-impc1c5c9
cat post-impc1c5c9.log >> post-imp-assoc-all.log

# With all PCs
plink \
        --bfile merge.filtered-updated \
        --covar ../../popstruct/ps-data.mds \
        --covar-name C1 C2 C3 C4 C5 C6 C7 C8 C9 C10 \
        --allow-no-sex \
        --autosome \
        --hide-covar \
        --logistic \
        --out post-impc1-c10
cat post-impc1-c10.log >> post-imp-assoc-all.log

# With all PCs and different MOI
plink \
        --bfile merge.filtered-updated \
        --covar ../../popstruct/ps-data.mds \
        --covar-name C1 C2 C3 C4 C5 C6 C7 C8 C9 C10 \
        --allow-no-sex \
        --autosome \
        --hide-covar \
        --model \
        --out post-impc1-c10-model
cat post-impc1-c10-model.log >> post-imp-assoc-all.log

# With all PCs and hethom MOI
plink \
        --bfile merge.filtered-updated \
        --covar ../../popstruct/ps-data.mds \
        --covar-name C1 C2 C3 C4 C5 C6 C7 C8 C9 C10 \
        --allow-no-sex \
        --autosome \
        --hide-covar \
        --logistic hethom \
        --out post-impc1-c10-hethom
cat post-impc1-c10-hethom.log >> post-imp-assoc-all.log
#########################################################################
#                        Plot Association in R                          #
#########################################################################

# Filter association results to obtain SNPs with p-val 1e-5
#for i in ps*-qc-camgwas.assoc.logistic; 
#do 
#	head -1 ${i} > ${i/-qc-camgwas.assoc.logistic/-assoc.results}; 
#	awk '$9<1e-5' ${i} >> ${i/-qc-camgwas.assoc.logistic/-assoc.results}; 
#done

# Produce manhattan plots in R
#R CMD BATCH post-imput-assoc.R

#mv *.png ../../images/

