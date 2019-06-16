#!/bin/bash

analysis="../../../analysis/"
samples="../../../samples/"
kgp="../../../1000G/"
imput="../../../assoc_results/"

# YRI ascertainment
#cut -f2 yri.bim > yriascertainment.rsids
#
#plink \
#	--bfile worldPops/world-pops-updated \
#	--extract yriascertainment.rsids \
#	--keep-allele-order \
#	--make-bed \
#	--out yriascertained
#
## YRI ascertainment
#plink \
#        --bfile worldPops/world-pops-updated \
#        --keep ${samples}yri.ids \
#        --maf 0.0001 \
#        --keep-allele-order \
#        --make-bed \
#        --out yri

cut -f2 cam-updated.bim > camascertainment.rsids
##
plink \
        --bfile worldPops/mergedSet \
        --extract camascertainment.rsids \
        --keep-allele-order \
	--pheno worldPops/update-1kgp.phe \
        --mpheno 1 \
	--maf 0.01 \
	--update-sex worldPops/update-1kgp.sex 1 \
        --make-bed \
        --out ascertained

# Prune to get only SNPs at linkage equilibrium (independent SNPs - no LD between them)
plink \
	--bfile ascertained \
	--indep-pairwise 50kb 10 0.2 \
	--allow-no-sex \
	--out prune

plink \
	--bfile ascertained \
	--autosome \
	--extract prune.prune.in \
	--maf $1 \
	--make-bed \
	--geno 0.01 \
	--out merged-data-pruned

# Convert bed to ped required for CONVERTF
plink \
	--bfile merged-data-pruned \
	--recode \
	--allow-no-sex \
	--keep-allele-order \
	--double-id \
	--out merged-data-pruned

mv merged-data-pruned.ped merged-data-pruned.map CONVERTF/

# Prepare ethnicity template file 
cut -f1 -d' ' cam-updated.fam > cam.ids
grep -f cam.ids ${samples}1471-eth_template.txt > cam.eth
sort --key=2 cam.eth > camAll.eth
cat camAll.eth worldPops/2504world.eth > merged-data-eth_template.txt

Rscript prepPopList.R
sed '1d' poplist.txt > CONVERTF/ethlist.txt

#rm phase* cam.eth cam.ids updatePhaseName.txt prune.*
