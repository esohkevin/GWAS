#!/bin/bash

analysis="../../../analysis/"
samples="../../../samples/"
kgp="../../../1000G/"

# Get 1kgp individuals limiting to only common SNPs that are found in qc-camgwas data
#plink \
#       --vcf ${kgp}Phase3_1kgpsnps.vcf.gz \
#       --autosome \
#       --keep-allele-order \
#       --mind 0.1 \
#       --geno 0.04 \
#       --expract extract-qc.rsids \
#       --hwe 1e-20 \
#       --pheno update-1kgp.phe \
#       --mpheno 1 \
#       --update-sex update-1kgp.sex 1 \
#       --allow-no-sex \
#       --indiv-sort f worldOrdered.txt \
#       --make-bed \
#       --exclude-snp rs16959560 \
#       --biallelic-only \
#       --out worldPops/world-pops

## Get updated raw-camgwas rsids
#cut -f2 ${analysis}qc-camgwas-updated.bim | sort | uniq > qc-camgwas-updated.ids
#
## Extract only SNPs with rsIDs
#plink \
#	--bfile worldPops/world-pops \
#	--allow-no-sex \
#	--extract qc-camgwas-updated.ids \
#	--make-bed \
#	--out worldPops/qc-rsids-world

cut -f2 worldPops/world-pops.bim > world.rsids
sort world.rsids | uniq -u > world-uniq.rsids

plink \
	--bfile worldPops/world-pops \
	--keep-allele-order \
	--exclude badSnps.txt \
	--make-bed \
	--extract world-uniq.rsids \
	--out world

cut -f1,4 world.bim | sed 's/\t/:/g' > world.pos
cut -f2 world.bim > world.rsids
paste world.pos world.rsids > updateWorldName.txt 

plink \
	--bfile world \
	--keep-allele-order \
	--update-name updateWorldName.txt 1 2 \
	--make-bed \
	--out worldPops/world-pops-updated

rm qc-camgwas-updated.ids
