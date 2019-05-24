#!/bin/bash

## Thin qc-camgwas-updated dataset for LD
# Prune the qc-dataset for SNPs within 50bp with r^2 < 0.2 using a window of 5 SNPs
plink \
        --bfile ../../analysis/qc-camgwas-updated \
        --indep-pairwise 50 5 0.2 \
        --allow-no-sex \
        --autosome \
        --biallelic-only \
        --out qc-ldPruned

plink \
        --bfile ../../analysis/qc-camgwas-updated \
        --extract qc-ldPruned.prune.in \
        --allow-no-sex \
        --autosome \
	--keep-allele-order \
        --make-bed \
        --out qc-camgwas-ldPruned
#
plink \
	--bfile qc-camgwas-ldPruned \
	--make-bed \
	--allow-no-sex \
	--keep-allele-order \
	--double-id \
	--out qc-camgwas-ldPruned

# Perform admixture cross-validation to determine the appropriate k value to use
for k in $(seq 1 2); do
	admixture --cv qc-camgwas-ldPruned.bed "${k}" | tee log${k}.out;
done

echo -e "\nDone Cross-Validating!"
echo "Please inspect the results and make a choice of k and"
echo "run admixture with your choice"

