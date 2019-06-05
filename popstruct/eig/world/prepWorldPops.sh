#!/bin/bash

analysis="../../../analysis/"
samples="../../../samples/"
kgp="../../../1000G/"
phase="../../../phase/"

# Get 1kgp individuals limiting to only common SNPs that are found in qc-camgwas data
plink \
       --vcf ${kgp}Phase3_1kgpsnps.vcf.gz \
       --autosome \
       --keep-allele-order \
       --mind 0.1 \
       --geno 0.04 \
       --extract phase-uniq.rsids \
       --hwe 1e-20 \
       --pheno worldPops/update-1kgp.phe \
       --mpheno 1 \
       --update-sex worldPops/update-1kgp.sex 1 \
       --allow-no-sex \
       --indiv-sort f worldPops/worldOrdered.txt \
       --make-bed \
       --exclude-snp rs16959560 \
       --biallelic-only \
       --out worldPops/world-pops
cat worldPops/world-pops.log > log.file

cut -f2 worldPops/world-pops.bim > world.rsids
sort world.rsids | uniq -u > world-uniq.rsids

plink \
	--bfile worldPops/world-pops \
	--keep-allele-order \
	--exclude badSnps.txt \
	--make-bed \
	--extract world-uniq.rsids \
	--out world
cat world.log >> log.file

cut -f1,4 world.bim | sed 's/\t/:/g' > world.pos
cut -f2 world.bim > world.rsids
paste world.pos world.rsids > updateWorldName.txt 

plink \
	--bfile world \
	--keep-allele-order \
	--update-name updateWorldName.txt 1 2 \
	--make-bed \
	--out worldPops/world-pops-updated
cat worldPops/world-pops-updated.log >> log.file


rm world.rsids world-uniq.rsids updateWorldName.txt world.pos world.rsids
