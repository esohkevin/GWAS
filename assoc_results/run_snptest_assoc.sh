#!/bin/bash

sample_path="$HOME/GWAS/Git/GWAS/samples/"
phase_path="$HOME/GWAS/Git/GWAS/phase/imputed/"

# Perform only bayesian for now. Add '-frequentist 1 2 3 5 \' to the command line to perform frequentist tests

for chunk in "${phase_path}"chr1_*_imputed.gen; do
    snptest_v2.5.4-beta3 \
	-data "${chunk}" "${sample_path}"qc-camgwas.sample \
	-bayesian 1 2 3 5 \
	-method score \
	-pheno pheno1 \
	-cov_all \
	-o ${chunk/_imputed.gen/_assoc.txt}
done

mv ${phase_path}*_assoc.txt .
