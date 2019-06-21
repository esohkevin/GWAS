#!/bin/bash

kgp="../phase/1000GP_Phase3/"
analysis="../analysis/"
phase="../phase/"

#plink \
#	--bfile raw-cam-controls \
#	--allow-no-sex \
#	--update-name updaterawName.txt 1 2 \
#	--make-bed \
#	--out raw-updated
#
#plink \
#	--bfile raw-updated \
#	--allow-no-sex \
#	--freq \
#	--out raw-updated
#
#Rscript palindromicsnps.R

perl ${analysis}HRC-1000G-check-bim.pl -b raw-updated.bim -f raw-updated.frq -r ${kgp}1000GP_Phase3_combined.legend.gz -g -p "AFR"


