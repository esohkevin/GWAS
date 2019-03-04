#!/bin/bash

# Extract population from each into separate files

for file in include_*; do
plink \
	--vcf ../1000G/Phase3_merged.vcf.gz \
	--keep $file \
	--autosome \
	--extract qc-rs.ids \
	--allow-no-sex \
	--make-bed \
	--exclude-snp rs16959560 \
	--biallelic-only \
	--out 1kGp3_$file

done

# Split qc-camgwas data by region (Buea, Y'de and D'la)
for file in *_sample.ids; do
plink \
	--bfile ../analysis/qc-camgwas-updated-autosome \
	--keep $file \
	--allow-no-sex \
	--make-bed \
	--out ${file/.ids/s};

done
