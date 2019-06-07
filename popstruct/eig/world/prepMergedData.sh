#!/bin/bash

analysis="../../../analysis/"
samples="../../../samples/"
kgp="../../../1000G/"
phase="../../../phase/"

## Extract YRI IDs for acertainment of Fst estimates
grep "YRI" igsr_pops.txt | cut -f1 > yri.txt

if [[ -f "yri.ids" ]]; then 
   rm yri.ids
fi

for id in `cat yri.txt`;
    do echo ${id} ${id} >> yri.ids;
done

plink \
        --bfile worldPops/world-pops-updated \
        --autosome \
	--maf 0.01 \
        --keep yri.ids \
        --make-bed \
        --out yri
cat yri.log >> log.file

cut -f2 yri.bim > yriAcertainment.rsids

## Update Phased study data
cut -f2 ${phase}phasedCamgwasAutosome.bim > phase.rsids
sort phase.rsids | uniq -u > phase-uniq.rsids

plink \
        --bfile ${phase}phasedCamgwasAutosome \
        --keep-allele-order \
        --exclude badSnps.txt \
        --make-bed \
        --extract phase-uniq.rsids \
        --out phase
cat phase.log >> log.file

cut -f1,4 phase.bim | sed 's/\t/:/g' > phase.pos
cut -f2 phase.bim > phase.rsids
paste phase.pos phase.rsids > updatePhaseName.txt

plink \
        --bfile phase \
        --keep-allele-order \
        --update-name updatePhaseName.txt 1 2 \
        --make-bed \
        --out worldPops/phased-data-updated
cat worldPops/phased-data-updated.log >> log.file

plink \
	--bfile worldPops/phased-data-updated \
	--allow-no-sex \
	--bmerge worldPops/world-pops-updated \
	--merge-equal-pos \
	--out worldPops/qc-world-merge
cat worldPops/qc-world-merge.log >> log.file

cut -f2 worldPops/phased-data-updated.bim > phased.rsids
	
# Now extract yriAcertainment SNPs
plink \
	--bfile worldPops/qc-world-merge \
	--keep-allele-order \
	--extract yriAcertainment.rsids \
	--make-bed \
	--out yriacertained
cat yriacertained.log >> log.file

# Prune to get only SNPs at linkage equilibrium (independent SNPs - no LD between them)
plink \
	--bfile yriacertained \
	--indep-pairwise 50 5 0.2 \
	--allow-no-sex \
	--extract phased.rsids \
	--out prune
cat prune.log >> log.file

plink \
	--bfile worldPops/qc-world-merge \
	--autosome \
	--maf 0.35 \
	--make-bed \
	--out merged-data-pruned
cat merged-data-pruned.log >> log.file

# Convert bed to ped required for CONVERTF
plink \
	--bfile merged-data-pruned \
	--recode \
	--allow-no-sex \
	--keep-allele-order \
	--double-id \
	--out merged-data-pruned
cat merged-data-pruned.log >> log.file

mv merged-data-pruned.ped merged-data-pruned.map CONVERTF/

# Prepare ethnicity template file 
cut -f1 -d' ' worldPops/phased-data-updated.fam > cam.ids
grep -f cam.ids ${samples}1471-eth_template.txt > cam.eth
sort --key=2 cam.eth > camAll.eth
cat camAll.eth worldPops/2504world.eth > merged-data-eth_template.txt
mv merged-data-pruned* ../../admixture/

rm phase* yri* cam.eth cam.ids updatePhaseName.txt prune.*
