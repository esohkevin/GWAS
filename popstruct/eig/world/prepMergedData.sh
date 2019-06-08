#!/bin/bash

analysis="../../../analysis/"
samples="../../../samples/"
kgp="../../../1000G/"
phase="../../../phase/"

# Update Phased study data
#cut -f2 ${phase}phasedCamgwasAutosome.bim > phase.rsids
#sort phase.rsids | uniq -u > phase-uniq.rsids
#
#plink \
#        --bfile ${phase}phasedCamgwasAutosome \
#        --keep-allele-order \
#        --exclude badSnps.txt \
#        --make-bed \
#        --extract phase-uniq.rsids \
#        --out phase
#
#cut -f1,4 phase.bim | sed 's/\t/:/g' > phase.pos
#cut -f2 phase.bim > phase.rsids
#paste phase.pos phase.rsids > updatePhaseName.txt
#
#plink \
#        --bfile phase \
#        --keep-allele-order \
#        --update-name updatePhaseName.txt 1 2 \
#        --make-bed \
#        --out worldPops/phased-data-updated
#
#plink \
#	--bfile worldPops/phased-data-updated \
#	--allow-no-sex \
#	--bmerge worldPops/world-pops-updated \
#	--merge-equal-pos \
#	--out worldPops/qc-world-merge

#cut -f2 worldPops/phased-data-updated.bim > phased.rsids
	
### Extract YRI IDs for acertainment of Fst estimates
plink \
        --bfile worldPops/world-pops-updated \
        --autosome \
        --maf 0.01 \
	--hwe 1e-08 \
        --geno 0.01 \
        --keep ${samples}yri.ids \
        --make-bed \
        --out yri

cut -f2 yri.bim > yriAcertainment.rsids

# Now extract yriAcertainment SNPs
plink \
	--bfile worldPops/qc-world-merge \
	--keep-allele-order \
	--extract yriAcertainment.rsids \
	--make-bed \
	--out ascertained

# Prune to get only SNPs at linkage equilibrium (independent SNPs - no LD between them)
plink \
	--bfile ascertained \
	--indep-pairwise 50 5 0.2 \
	--allow-no-sex \
	--out prune

plink \
	--bfile ascertained \
	--autosome \
	--extract prune.prune.in \
	--maf 0.35 \
	--geno 0.01 \
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

rm phase* yri* cam.eth cam.ids updatePhaseName.txt prune.*
