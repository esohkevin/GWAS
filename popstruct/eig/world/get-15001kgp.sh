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


