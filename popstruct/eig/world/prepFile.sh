#!/bin/bash

analysis="../../../analysis/"
samples="../../../samples/"
kgp="../../../1000G/"
phase="../../../phase/"

### Extract YRI IDs for acertainment of Fst estimates
plink \
        --bfile worldPops/world-pops-updated \
        --autosome \
        --keep ${samples}chb.ids \
        --make-bed \
	--maf 0.01 \
	--hwe 1e-12 \
	--geno 0.04 \
        --out chb

cut -f2 chb.bim > chbAcertainment.rsids


cut -f2 worldPops/phased-data-updated.bim > phased.rsids
	
### Extract YRI IDs for acertainment of Fst estimates
plink \
        --bfile worldPops/world-pops-updated \
        --autosome \
	--extract chbAcertainment.rsids \
        --make-bed \
        --out worldascertained

cut -f2 worldascertained.bim > worldascertained.rsids

# Now extract yriAcertainment SNPs
plink \
	--bfile worldPops/phased-data-updated \
	--keep-allele-order \
	--extract worldascertained.rsids \
	--make-bed \
	--out camascertained

# Ascertain CAM 
plink \
	--bfile camascertained \
	--bmerge worldascertained \
	--keep-allele-order \
	--out ascertained

# Prune to get only SNPs at linkage equilibrium (independent SNPs - no LD between them)
plink \
	--bfile ascertained \
	--indep-pairwise 50kb 1 0.2 \
	--allow-no-sex \
	--out prune

plink \
	--bfile ascertained \
	--autosome \
	--maf $1 \
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

# Prepare ethnicity template file 
cut -f1 -d' ' worldPops/phased-data-updated.fam > cam.ids
grep -f cam.ids ${samples}1471-eth_template.txt > cam.eth
sort --key=2 cam.eth > camAll.eth
cat camAll.eth worldPops/2504world.eth > merged-data-eth_template.txt
mv merged-data-pruned* ../../admixture/

rm phase* yri.* cam.eth cam.ids updatePhaseName.txt prune.* worldascertained* camascertained*
