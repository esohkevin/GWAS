#!/bin/bash

analysis="../../analysis/"
samples="../../samples/"
kgp="../../1000G/"
world="../eig/world/"
phase="../../phase/"

# Extract only a subset of world Pops to use (YRI+LWK+GWD+GBR+CHS+BEB+PUR). 
# The ids are stored in worldPops.ids
cat cam.ids yri.ids adm.txt > adm.pops
cut -f2 ${world}yri.bim > yri.rsids


plink \
        --bfile merged-data-pruned \
        --allow-no-sex \
	--extract yri.rsids \
        --autosome \
	--keep adm.pops \
	--indiv-sort f adm.order \
	--make-bed \
        --out merge
at merge.log > log.file

# Prune to get only SNPs at linkage equilibrium (independent SNPs - no LD between them)
plink \
	--bfile merge \
	--indep-pairwise 50 5 0.2 \
	--allow-no-sex \
	--out prune
cat prune.log >> log.file

plink \
	--bfile merge \
	--autosome \
	--maf 0.35 \
	--extract prune.prune.in \
	--make-bed \
	--out adm-data
cat adm-data.log >> log.file

# Prepare .pop file
Rscript prepMergedData.R






#rm yri.txt yri.bim yri.bed yri.fam prune* studyPops*


