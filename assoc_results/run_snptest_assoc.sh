#!/bin/bash

sample_path="$HOME/GWAS/Git/GWAS/samples/"
phase_path="$HOME/GWAS/Git/GWAS/phase/"

snptest_v2.5.4-beta3 \
	-data "${phase_path}"chr1_test_imput2.gen "${sample_path}"qc-camgwas.sample \
	-frequentist 2 3 5 \
	-bayesian 2 3 5 \
	-method score \
	-pheno pheno1 \
	-cov_all \
	-o snptest_assoc_test_imp.txt
