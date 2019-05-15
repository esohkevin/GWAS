#!/bin/bash

# --thin-indiv-count 1500 \ add this line to get only 1500 individuals from 1KGP

# Get 1kgp individuals limiting to only common SNPs that are found in qc-camgwas data
plink \
	--vcf ../../../1000G/Phase3_merged.vcf.gz \
	--autosome \
	--extract updated-qc.rsids \
	--keep-allele-order \
	--mind 0.1 \
	--maf 0.35 \
	--geno 0.01 \
	--pheno update-1kgp.phe \
        --mpheno 1 \
        --update-sex update-1kgp.sex 1 \
	--allow-no-sex \
	--make-bed \
	--exclude-snp rs16959560 \
	--biallelic-only \
	--out qc-rsids-world-pops

# Get a subset of individuals from qc-camgwas to merge with individuals from 1kgp
plink \
	--bfile ../../../analysis/qc-camgwas-updated \
	--allow-no-sex \
	--thin-indiv-count 300 \
	--make-bed \
	--out thinned-qc-camgwas

# Get the rsIDs of the SNPs in the thinned-qc-camgwas file to use for merging with world pops
cut -f2 thinned-qc-camgwas.bim > thinned-qc-rs.ids

# Merge thinned qc-data with common SNPs
plink \
	--bfile thinned-qc-camgwas \
	--allow-no-sex \
	--bmerge qc-rsids-world-pops \
	--make-bed \
	--out qc-world-merge \
	--extract thinned-qc-rs.ids

# Prune to get only SNPs at linkage equilibrium (independent SNPs - no LD between them)
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
