#!/bin/bash

analysis="../../../analysis/"
samples="../../../samples/"
kgp="../../../1000G/"
phase="../../../phase/"

# Extract YRI IDs for acertainment of Fst estimates
grep "YRI" igsr_pops.txt | cut -f1 > yri.txt

if [[ -f "yri.ids" ]]; then 
   rm yri.ids
fi

for id in `cat yri.txt`;
    do echo ${id} ${id} >> yri.ids;
done

plink \
        --bfile worldPops/world-pops \
        --autosome \
	--maf 0.35 \
        --keep yri.ids \
        --make-bed \
        --out yri

cut -f2 yri.bim > yriAcertainment.rsids

# Prepared world pop data extracting only YRI rsids
plink \
	--bfile worldPops/world-pops \
	--extract yriAcertainment.rsids \
	--allow-no-sex \
	--autosome \
	--make-bed \
	--out qc-world
#
#cut -f2 qc-world.bim > qc-world.rsids

# Get only Foulbe individuals from qc-camgwas
plink \
        --bfile ${phase}phasedCamgwasAutosome \
        --allow-no-sex \
        --keep ${samples}exclude_fo.txt \
	--extract yriAcertainment.rsids \
	--autosome \
        --make-bed \
        --out fo-camgwas
cat fo-camgwas.log >> log.file

# Get only Semi-Bantu and Bantu individuals from qc-camgwas while thinning to 250
plink \
	--bfile ${phase}phasedCamgwasAutosome \
	--allow-no-sex \
	--extract yriAcertainment.rsids \
	--thin-indiv-count 250 \
	--remove ${samples}exclude_fo.txt \
	--make-bed \
	--autosome \
	--out 250SB-camgwas
cat 250SB-camgwas.log >> log.file

# Now merge the Foulbe and the Semi-Bantu and Bantu populations
plink \
	--bfile 250SB-camgwas \
	--bmerge fo-camgwas \
	--keep-allele-order \
	--out temp279SBF
#cat thinned-qc-camgwas.log >> log.file
cut -f1 temp279SBF.fam > cam.ids
grep -f cam.ids ${samples}1471-eth_template.txt > 279cam.eth
sort --key=2 279cam.eth > cam279.eth
for id in `cut -f1 -d' ' cam279.eth`; do echo ${id} ${id}; done > camOrder.txt
 
# Get only rsids common to all pops
plink \
        --bfile temp279SBF \
        --keep-allele-order \
	--make-bed \
	--indiv-sort f camOrder.txt \
	--exclude badSnps.txt \
        --out thinned-qc-camgwas

# Merge thinned qc-data with common SNPs
plink \
	--bfile thinned-qc-camgwas \
	--allow-no-sex \
	--bmerge qc-world \
	--out qc-world-merge
cat qc-world-merge.log >> log.file

# Prune to get only SNPs at linkage equilibrium (independent SNPs - no LD between them)
plink \
	--bfile qc-world-merge \
	--indep-pairwise 50 5 0.2 \
	--allow-no-sex \
	--out prune
cat prune.log >> log.file

plink \
	--bfile qc-world-merge \
	--autosome \
	--extract prune.prune.in \
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
#rm fo-camgwas* prune* qc-world* thinned-qc-camgwas* 250SB-camgwas*
#rm *.log yri.* world.bim world.bed world.fam

# Prepare ethnicity template file 
#cut -f1 merged-data-pruned.fam > cam.id
#grep -f cam.id ${samples}1471-eth_template.txt > 279cam.eth
#grep -f 1kgp.id igsr_pops.txt | cut -f1,3 > 2504world.eth
#sort --key=2 279cam.eth > cam279.eth
#cat cam279.eth 2504world.eth > merged-data-eth_template.txt
#rm 279cam.eth cam.id
#rm merged-data-pruned*
