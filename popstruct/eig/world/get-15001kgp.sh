#!/bin/bash

plink \
	--vcf ../../../1000G/Phase3_merged.vcf.gz \
	--thin-indiv-count 1500 \
	--autosome \
	--extract updated-qc.rsids \
	--keep-allele-order \
	--mind 0.1 \
	--maf 0.35 \
	--geno 0.01 \
	--allow-no-sex \
	--make-bed \
	--exclude-snp rs16959560 \
	--biallelic-only \
	--out qc-rsids-world-pops

# Merge qc-data with common SNPs
plink \
	--bfile ../../../analysis/qc-camgwas-updated \
	--allow-no-sex \
	--bmerge qc-rsids-world-pops \
	--make-bed \
	--out qc-world-merge \
	--extract ../../qc-rs.ids

# Prune to get only SNPs with near linkage equilibrium
plink \
	--bfile qc-world-merge \
	--indep-pairwise 50 5 0.2 \
	--allow-no-sex \
	--biallelic-only \
	--out prune

plink \
	--bfile qc-world-merge \
	--autosome \
	--extract prune.prune.in \
	--make-bed \
	--out merged-data-pruned

# Convert bed to ped required for CONVERTF
plink \
	--bfile merged-data-pruned \
	--recode \
	--allow-no-sex \
	--keep-allele-order \
	--double-id \
	--out merged-data-pruned
