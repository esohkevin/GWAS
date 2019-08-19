#!/bin/bash

analysis="../../analysis/"
samples="../../samples/"
kgp="../../1000G/"
phase="../../phase/"
imput="../../assoc_results/"

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

## Update Phased study data
#cut -f2 ${analysis}qc-camgwas-updated.bim > qc-camgwas.rsids
#sort qc-camgwas.rsids | uniq -u > qc-camgwas-uniq.rsids
#
#plink \
#        --bfile ${analysis}qc-camgwas-updated \
#        --keep-allele-order \
#	--keep ${samples}eig.ids \
#        --exclude badSnps.txt \
#        --make-bed \
#	--filter-controls \
#        --extract qc-camgwas-uniq.rsids \
#        --out qc-camgwas
#
#cut -f1,4 qc-camgwas.bim | sed 's/\t/:/g' > qc-camgwas.pos
#cut -f2 qc-camgwas.bim > qc-camgwas.rsids
#paste qc-camgwas.pos qc-camgwas.rsids > updatePhaseName.txt
#
####################################################################
##	Get study sample IDs for downstream processes		  #
##								  #
#	awk '{print $1}' qc-camgwas.fam > cam.ids
##								  #
####################################################################
#
#plink \
#        --bfile qc-camgwas \
#        --keep-allele-order \
#        --filter-controls \
#        --update-name updatePhaseName.txt 1 2 \
#        --make-bed \
#        --out worldPops/qc-camgwas-data-updated
#
#plink \
#	--bfile worldPops/qc-camgwas-data-updated \
#	--allow-no-sex \
#	--bmerge worldPops/world-pops-updated \
#	--merge-equal-pos \
#	--out worldPops/qc-world-temp1
#
## Update merged data rsids with dbSNP 151 ids
#plink \
#        --bfile worldPops/qc-world-temp1 \
#        --keep-allele-order \
#        --update-name ${analysis}updateName.txt 1 2 \
#        --make-bed \
#        --out worldPops/qc-world-temp2

# Update status - all controls
plink \
	--bfile worldPops/qc-world-temp2 \
	--keep-allele-order \
	--pheno worldPops/update-1kgp.phe \
        --mpheno 1 \
        --update-sex worldPops/update-1kgp.sex 1 \
	--make-bed \
	--out worldPops/qc-world-merge

# Extract only SNPs present in study dataset
plink \
	--bfile worldPops/qc-world-merge \
	--extract worldPops/camcon.rsids \
	--hwe 1e-8 \
	--make-bed \
	--out temp-merge \
	--autosome

# Re-affirm ref/alt allele assignment
plink2 \
	--bfile temp-merge \
	--ref-allele force ${analysis}refSites.txt 4 1 \
	--make-bed \
	--out worldPops/merge-set

# Make vcf for phasing
plink \
	--bfile worldPops/merge-set \
	--recode vcf-fid bgz \
	--real-ref-alleles \
	--keep-allele-order \
	--out merge-set

tabix -f -p vcf merge-set.vcf.gz
bcftools sort merge-set.vcf.gz -Oz -o merge-set.vcf.gz

mv merge-set.vcf.gz ${phase}

for file in worldPops/*~ worldPops/*temp* qc-camgwas* temp* worldPops/*.nosex *.nosex; do
    if [[ -f $file ]]; then
	 rm $file
    fi
done
