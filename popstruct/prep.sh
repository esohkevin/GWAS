#!/bin/bash

kgp="../phase/1000GP_Phase3/"
analysis="../analysis/"
phase="../phase/"

plink \
	--bfile ${analysis}raw-camgwas \
	--autosome \
	--allow-no-sex \
	--maf 0.001 \
	--keep controls558.ids.txt \
	--make-bed \
	--out raw-cam-controls

plink \
	--bfile raw-cam-controls \
	--allow-no-sex \
	--update-name ../analysis/updateName.txt 1 2 \
	--make-bed \
	--out raw

plink \
	--bfile raw \
	--make-bed \
	--out raw
rm *~

plink \
	--bfile camChr11 \
	--allow-no-sex \
	--freq \
	--out cam11

Rscript palindromicsnps.R

perl HRC-1000G-check-bim.pl -b cam11.bim -f cam11.frq -r ${kgp}1000GP_Phase3_combined.legend.gz -g -p "AFR"

./update-plink.sh

./plink2vcf.sh

./vcfcheck.sh
