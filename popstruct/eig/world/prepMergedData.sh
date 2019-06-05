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
#cat phase.log >> log.file
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
## Merge 1kgp3 with entire phased camgwas dataset
#plink \
#        --bfile worldPops/phased-data-updated \
#        --allow-no-sex \
#        --bmerge worldPops/world-pops-updated \
#        --merge-equal-pos \
#        --out worldPops/cam1kgpMerge
#cat cam1kgpMerge.log >> log.file
#
# Get only Foulbe individuals from qc-camgwas
#plink \
#        --bfile worldPops/phased-data-updated \
#        --allow-no-sex \
#        --keep ${samples}exclude_fo.txt \
#	--autosome \
#        --make-bed \
#        --out fo-camgwas
#cat fo-camgwas.log >> log.file
#
## Get only Semi-Bantu and Bantu individuals from qc-camgwas while thinning to 250
#plink \
#	--bfile worldPops/phased-data-updated \
#	--allow-no-sex \
#	--thin-indiv-count 250 \
#	--remove ${samples}exclude_fo.txt \
#	--make-bed \
#	--autosome \
#	--out 250SB-camgwas
#cat 250SB-camgwas.log >> log.file
#
## Now merge the Foulbe and the Semi-Bantu and Bantu populations
#plink \
#	--bfile 250SB-camgwas \
#	--bmerge fo-camgwas \
#	--keep-allele-order \
#	--out temp279SBF
##cat thinned-qc-camgwas.log >> log.file
#cut -f1 temp279SBF.fam > cam.ids
#grep -f cam.ids ${samples}1471-eth_template.txt > 279cam.eth
#sort --key=2 279cam.eth > cam279.eth
#for id in `cut -f1 -d' ' cam279.eth`; do echo ${id} ${id}; done > camOrder.txt
 
# Get only rsids common to all pops
#plink \
#        --bfile temp279SBF \
#        --keep-allele-order \
#        --flip badSnps.txt \
#	--make-bed \
#	--indiv-sort f camOrder.txt \
#	--exclude badSnps.txt \
#        --out thinned-qc-camgwas
#
#cut -f1,2 -d' ' thinned-qc-camgwas.fam > ../../admixture/cam.ids
# Merge thinned qc-data with common SNPs
#touch qc-world-merge.missnp
#file=qc-world-merge.missnp
#while [ -s "$file" ]; do
#      cat qc-world-merge.missnp >> badSnps.txt
#      ./prepWorldPops.sh



######################## Refined ############################

#plink \
#	--bfile worldPops/phased-data-updated \
#	--allow-no-sex \
#	--bmerge worldPops/world-pops-updated \
#	--merge-equal-pos \
#	--out worldPops/qc-world-merge
#cat worldPops/qc-world-merge.log >> log.file
#done
	
# Now extract yriAcertainment SNPs
plink \
	--bfile worldPops/qc-world-merge \
	--keep-allele-order \
	--extract yriAcertainment.rsids \
	--make-bed \
	--out yriacertained

# Prune to get only SNPs at linkage equilibrium (independent SNPs - no LD between them)
plink \
	--bfile yriacertained \
	--indep-pairwise 50 5 0.2 \
	--allow-no-sex \
	--out prune
cat prune.log >> log.file

plink \
	--bfile worldPops/qc-world-merge \
	--autosome \
	--maf 0.35 \
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
#rm fo-camgwas* prune* qc-world* 250SB-camgwas*
#rm *.log yri.txt yri.bim yri.bed yri.fam

# Prepare ethnicity template file 
#cut -f1 merged-data-pruned.fam > cam.id
#cat cam279.eth 2504world.eth > merged-data-eth_template.txt
cut -f1 -d' ' worldPops/phased-data-updated.fam > cam.ids
grep -f cam.ids ${samples}1471-eth_template.txt > cam.eth
sort --key=2 cam.eth > camAll.eth
cat camAll.eth 2504world.eth > merged-data-eth_template.txt
#rm 279cam.eth cam.id
mv merged-data-pruned* ../../admixture/

./run_popgen.sh
