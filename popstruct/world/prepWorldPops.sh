#!/bin/bash

analysis="../../analysis/"
samples="../../samples/"
kgp="../../1000G/"
imput="../../assoc_results/"
phase="../../phase/"

# Get 1kgp individuals limiting to only common SNPs that are found in qc-camgwas data
#plink \
#       --vcf ${kgp}Phase3_1kgpsnps.vcf.gz \
#       --autosome \
#       --keep-allele-order \
#       --mind 0.1 \
#       --geno 0.04 \
#       --hwe 1e-20 \
#       --mpheno 1 \
#       --update-sex worldPops/update-1kgp.sex 1 \
#       --allow-no-sex \
#       --indiv-sort f worldPops/worldOrdered.txt \
#       --make-bed \
#       --exclude-snp rs16959560 \
#       --biallelic-only \
#       --out worldPops/world-pops
#
#cut -f2 worldPops/world-pops.bim > world.rsids
#sort world.rsids | uniq -u > world-uniq.rsids
#
#plink \
#	--bfile worldPops/world-pops \
#	--keep-allele-order \
#	--exclude badSnps.txt \
#	--make-bed \
#	--extract world-uniq.rsids \
#	--out world
#
#cut -f1,4 world.bim | sed 's/\t/:/g' > world.pos
#cut -f2 world.bim > world.rsids
#paste world.pos world.rsids > updateWorldName.txt 
#
#plink \
#	--bfile world \
#	--keep-allele-order \
#	--update-name updateWorldName.txt 1 2 \
#	--make-bed \
#	--out worldPops/world-pops-updated
#
#rm world.rsids world-uniq.rsids updateWorldName.txt world.pos world.rsids
#
## Prepare study data and merge with world
#cut -f1,4 ${imput}phasedWrefImpute2Biallelic.bim | sed 's/\t/:/g' > cam-nodups.pos
#cut -f2 ${imput}phasedWrefImpute2Biallelic.bim > cam-nodups.rsids
#paste cam-nodups.pos cam-nodups.rsids > updatePhaseName.txt
#
#plink \
#        --bfile ${imput}phasedWrefImpute2Biallelic \
#        --keep-allele-order \
#        --extract camrsids.txt \
#        --make-bed \
#        --out cam
#
#plink \
#        --bfile cam \
#        --keep-allele-order \
#        --update-name updatePhaseName.txt 1 2 \
#        --make-bed \
#        --out cam-updated
##rm cam.*
#
#cut -f2 cam-updated.bim > cam-updated-rsids.txt

#if [[ -f "merge.list" ]]; then
#   rm merge.list
#fi
#
#echo "cam-updated" > merge.list
#
for pop in `cat pop.list`; do
    plink \
        --bfile worldPops/world-pops-updated \
        --autosome \
        --maf 0.01 \
	--extract cam-updated-rsids.txt \
        --hwe 1e-20 \
	--exclude worldPops/mergedSet.missnp \
        --geno 0.04 \
	--pheno worldPops/update-1kgp.phe \
        --mpheno 1 \
	--update-sex worldPops/update-1kgp.sex 1 \
        --keep ${samples}"${pop}".ids \
        --make-bed \
        --out ${pop}
#
#    echo "${pop}" >> merge.list
done

# Get Cam control samples
#plink \
#        --bfile cam-updated \
#        --filter-controls \
#        --make-bed \
#	--keep ${samples}eig.ids \
#        --keep-allele-order \
#        --out cam-controls
#
#plink \
#        --bfile cam-controls \
#	--bmerge worldPops/world-pops-updated \
#        --keep-allele-order \
#        --out worldPops/mergedSet

## Update Phased study data
#cut -f2 ${phase}phasedCamgwasAutosome.bim > phase.rsids
#sort phase.rsids | uniq -u > phase-uniq.rsids
#
#plink \
#        --bfile ${phase}phasedCamgwasAutosome \
#        --keep-allele-order \
#	--keep ${samples}eig.ids \
#        --exclude badSnps.txt \
#        --make-bed \
#	--filter-controls \
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
#        --filter-controls \
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

# Update merged data rsids with dbSNP 151 ids
#plink \
#        --bfile worldPops/qc-world-merge \
#        --keep-allele-order \
#        --update-name ${analysis}updateName.txt 1 2 \
#        --make-bed \
#        --out worldPops/qc-world-merge

#rm worldPops/*~
