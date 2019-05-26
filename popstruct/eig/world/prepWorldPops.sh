#!/bin/bash

analysis="../../../analysis/"
samples="../../../samples/"
kgp="../../../1000G/"

#cut -f2 ../../../analysis/qc-camgwas-updated.bim | grep "rs" > extract-qc.rsids

# --thin-indiv-count 1500 \ add this line to get only 1500 individuals from 1KGP

# Get 1kgp individuals limiting to only common SNPs that are found in qc-camgwas data
#plink \
#       --vcf ${kgp}Phase3_merged.vcf.gz \
#       --autosome \
#       --keep-allele-order \
#       --mind 0.1 \
#       --geno 0.01 \
#       --pheno update-1kgp.phe \
#       --mpheno 1 \
#       --update-sex update-1kgp.sex 1 \
#       --allow-no-sex \
#       --make-bed \
#       --exclude-snp rs16959560 \
#       --biallelic-only \
#       --out worldPops/world-pops

#cut -f2 worldPops/qc-rsids-world-pops.bim > 1kgp.rsid

# Get updated raw-camgwas rsids
#cut -f1,4 ${analysis}raw-camgwas.bim | \
#        sed 's/\t/:/g' > raw-camgwas.pos
#cut -f2 ${analysis}raw-camgwas.bim > raw-camgwas.ids
#paste raw-camgwas.ids raw-camgwas.pos > raw-camgwas-ids-pos.txt

#./remove_dups.perl raw-camgwas-ids-pos.txt > raw-camgwas-rsids-pos.txt

#plink \
#        --bfile ${analysis}raw-camgwas \
#        --update-name  raw-camgwas-rsids-pos.txt 2 1 \
#        --allow-no-sex \
#        --make-bed \
#        --out temp1
#cat qc-rsids-world.log >> log.file

#plink \
#        --bfile temp1 \
#        --update-name ${analysis}updateName.txt 1 2 \
#        --allow-no-sex \
#        --make-bed \
#        --out raw-camgwas-updated
#cut -f2 raw-camgwas-updated.bim > raw-updated.rsids


# Extract only SNPs with rsIDs
#cut -f2 worldPops/world-pops.bim | grep rs | sort | uniq > rsids.txt
plink \
	--bfile worldPops/world-pops \
	--allow-no-sex \
	--extract raw-updated.rsids \
	--make-bed \
	--out worldPops/qc-rsids-world

#echo """
#########################################################################
#                          Updating    rsids                            #
#########################################################################
#"""
#cut -f1,4 temp2.bim | \
#        sed 's/\t/:/g' > qc-rsids-world.pos
#cut -f2 temp2.bim > qc-rsids-world.ids
#paste qc-rsids-world.ids qc-rsids-world.pos > qc-rsids-world-ids-pos.txt

#./remove_dups.perl qc-rsids-world-ids-pos.txt > qc-rsids-world-rsids-pos.txt



#plink \
#        --bfile temp2 \
#        --update-name qc-rsids-world-rsids-pos.txt 2 1 \
#        --allow-no-sex \
#        --make-bed \
#        --out temp3
#cat qc-rsids-world.log >> log.file

#plink \
#        --bfile temp3 \
#        --update-map ${analysis}updateName.txt 2 1 \
#        --allow-no-sex \
#        --make-bed \
#        --out worldPops/qc-rsids-world-pops
#cat qc-rsids-world.log >> log.file

#rm temp*

