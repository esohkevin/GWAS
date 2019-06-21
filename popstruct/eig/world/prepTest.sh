#!/bin/bash

analysis="../../../analysis/"
samples="../../../samples/"
kgp="../../../1000G/"
phase="../../../phase/"

## Extract YRI IDs for acertainment of Fst estimates
#plink \
#        --bfile worldPops/world-pops-updated \
#        --autosome \
#	--maf 0.0001 \
#        --keep ${samples}yri.ids \
#        --make-bed \
#        --out yri
#cat yri.log >> log.file
#
#cut -f2 yri.bim > yriAcertainment.rsids

# Now extract yriAcertainment SNPs
plink \
	--bfile worldPops/qc-world-merge \
	--keep-allele-order \
	--make-bed \
	--extract yriAcertainment.rsids \
	--pheno worldPops/update-1kgp.phe \
        --mpheno 1 \
	--maf 0.0001 \
	--update-sex worldPops/update-1kgp.sex 1 \
	--out yriascertained

# Prune to get only SNPs at linkage equilibrium (independent SNPs - no LD between them)
plink \
	--bfile yriascertained \
	--indep-pairwise 50kb 1 0.2 \
	--allow-no-sex \
	--out prune

plink \
	--bfile yriascertained \
	--autosome \
	--maf $1 \
	--geno 0.04 \
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

mv merged-data-pruned.ped merged-data-pruned.map CONVERTF/
#rm fo-camgwas* prune* qc-world* 250SB-camgwas*
#rm *.log yri.txt yri.bim yri.bed yri.fam

# Prepare ethnicity template file 
#cut -f1 merged-data-pruned.fam > cam.id
#cat cam279.eth 2504world.eth > merged-data-eth_template.txt
cut -f1 -d' ' worldPops/phased-data-updated.fam > cam.ids
grep -f cam.ids ${samples}1471-eth_template.txt > cam.eth
sort --key=2 cam.eth > camAll.eth
cat camAll.eth worldPops/2504world.eth > merged-data-eth_template.txt
#rm 279cam.eth cam.id
#mv merged-data-pruned* ../../admixture/

#./run_popgen.sh
