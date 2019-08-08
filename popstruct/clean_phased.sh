#!/bin/bash

plink \
	--vcf chr11-imp-phased_wref.vcf.gz \
	--maf 0.01 \
	--geno 0.04 \
	--hwe 1e-8 \
	--recode vcf-fid bgz \
	--keep-allele-order \
	--allow-no-sex \
	--real-ref-alleles \
	--double-id \
	--out chr11-imputed

