#!/bin/bash

kgp="../phase/1000GP_Phase3/"
analysis="../analysis/"
phase="../phase/"

plink \
	--bfile ${analysis}raw-camgwas \
	--autosome \
	--allow-no-sex \
	--maf 0.001 \
	--filter-controls \
	--make-bed \
	--out raw-cam-controls

plink \
	--bfile raw-cam-controls \
	--allow-no-sex \
	--update-name updaterawName.txt 1 2 \
	--make-bed \
	--out raw

plink \
	--bfile raw \
	--exclude out.check.mono \
	--keep-allele-order \
	--make-bed \
	--out raw
#rm *~

plink \
	--bfile raw \
	--allow-no-sex \
	--freq \
	--out raw

Rscript palindromicsnps.R

perl HRC-1000G-check-bim.pl -b raw.bim -f raw.frq -r ${kgp}1000GP_Phase3_combined.legend.gz -g -p "AFR"

./update-plink.sh

./plink2vcf.sh

./vcfcheck.sh
