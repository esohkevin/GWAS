#!/bin/bash

# Run SNPTEST Association for entire dataset using casecontrol status (each chr at a time)
snptest_v2.5.4-beta3 \
	-data merge.filtered-updated.gen.gz merge.filtered-updated.sample \
	-frequentist 1 2 3 4 5 \
	-bayesian 1 2 3 4 5 \
	-method score \
	-pheno pheno1 \
	-cov_all \
	-o snptest-assoc.txt
#cut -f1-6,42,44,46-47 -d' ' snptest-assoc.txt | sed s/NA/"${i}"/g > snptest-assoc1.txt

###########################################################################################################################
# Run association for only CM Vs Controls (by including only control+CM samples from analysis)
snptest_v2.5.4-beta3 \
        -data merge.filtered-updated.gen.gz merge.filtered-updated.sample \
        -frequentist 1 2 3 4 5 \
        -bayesian 1 2 3 4 5 \
        -method score \
        -pheno pheno1 \
	-include_samples ../../samples/qc-cmcon-sample.ids \
        -cov_all \
        -o snptest-cm-assoc.txt
#cut -f1-6,42,44,46-47 -d' ' snptest-assoc.txt | sed s/NA/"${i}"/g > snptest-assoc1.txt


# Run association for only SMA Vs Controls (bu including only control+SMA samples from analysis)
snptest_v2.5.4-beta3 \
        -data merge.filtered-updated.gen.gz merge.filtered-updated.sample \
        -frequentist 1 2 3 4 5 \
        -bayesian 1 2 3 4 5 \
        -method score \
        -pheno pheno1 \
        -cov_all \
	-include_samples ../../samples/qc-smacon-sample.ids \
        -o snptest-sma-assoc.txt
#cut -f1-6,42,44,46-47 -d' ' chr"${i}"-sma-imputed-assoc.txt | sed s/NA/"${i}"/g > chr"${i}"-sma-imputed-assoc-truncated.txt

# Extract columns that for different tests into separate files
cut -f1-6,42,44 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-fadd-assoc.txt
cut -f1-6,46,48 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-fdom-assoc.txt
cut -f1-6,50,52 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-frec-assoc.txt
cut -f1-6,54,56 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-fgen-assoc.txt
cut -f1-6,60,62 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-fhet-assoc.txt
cut -f1-6,64,65 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-badd-assoc.txt
cut -f1-6,67,68 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-bdom-assoc.txt
cut -f1-6,70,71 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-brec-assoc.txt
cut -f1-6,73,74 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-bgen-assoc.txt
cut -f1-6,78,79 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-bhet-assoc.txt

# Extract columns that for different tests into separate files
cut -f1-6,42,44 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-fadd-assoc.txt
cut -f1-6,46,48 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-fdom-assoc.txt
cut -f1-6,50,52 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-frec-assoc.txt
cut -f1-6,54,56 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-fgen-assoc.txt
cut -f1-6,60,62 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-fhet-assoc.txt
cut -f1-6,64,65 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-badd-assoc.txt
cut -f1-6,67,68 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-bdom-assoc.txt
cut -f1-6,70,71 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-brec-assoc.txt
cut -f1-6,73,74 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-bgen-assoc.txt
cut -f1-6,78,79 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-bhet-assoc.txt

# Extract columns that for different tests into separate files
cut -f1-6,42,44 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-fadd-assoc.txt
cut -f1-6,46,48 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-fdom-assoc.txt
cut -f1-6,50,52 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-frec-assoc.txt
cut -f1-6,54,56 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-fgen-assoc.txt
cut -f1-6,60,62 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-fhet-assoc.txt
cut -f1-6,64,65 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-badd-assoc.txt
cut -f1-6,67,68 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-bdom-assoc.txt
cut -f1-6,70,71 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-brec-assoc.txt
cut -f1-6,73,74 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-bgen-assoc.txt
cut -f1-6,78,79 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-bhet-assoc.txt

