#!/bin/bash

# --thin-indiv-count 1500 \ add this line to get only 1500 individuals from 1KGP

cut -f2 ../../../analysis/qc-camgwas-updated.bim | cut -f1 -d':' > updated-qc.rsids

# Get 1kgp individuals limiting to only common SNPs that are found in qc-camgwas data
#plink \
#	--vcf ../../../1000G/Phase3_merged.vcf.gz \
#	--autosome \
#	--extract updated-qc.rsids \
#	--keep-allele-order \
#	--mind 0.1 \
#	--maf 0.35 \
#	--geno 0.01 \
#	--pheno update-1kgp.phe \
#        --mpheno 1 \
#        --update-sex update-1kgp.sex 1 \
#	--allow-no-sex \
#	--make-bed \
#	--exclude-snp rs16959560 \
#	--biallelic-only \
#	--out qc-rsids-world-pops

# Update rsids of world pop to match rsids of camgwas
# Update the rsids
plink \
        --bfile worldPops/qc-rsids-world-pops \
        --update-name updated-thinned-camgwas-rsids 2 1 \
        --allow-no-sex \
        --out world \
        --make-bed
cat world.log >> log.file
cut -f2 world.bim > common-ids.txt

# Get only Foulbe individuals from qc-camgwas
plink \
        --bfile ../../../analysis/qc-camgwas-updated \
        --allow-no-sex \
        --keep ../../../samples/exclude_fo.txt \
        --make-bed \
        --out fo-camgwas
cat fo-camgwas.log >> log.file

# Get only Semi-Bantu and Bantu individuals from qc-camgwas while thinning to 250
plink \
	--bfile ../../../analysis/qc-camgwas-updated \
	--allow-no-sex \
	--thin-indiv-count 250 \
	--remove ../../../samples/exclude_fo.txt \
	--make-bed \
	--out 250SB-camgwas
cat 250SB-camgwas.log >> log.file

# Now merge the Foulbe and the Semi-Bantu and Bantu populations
plink \
	--bfile 250SB-camgwas \
	--bmerge fo-camgwas \
	--keep-allele-order \
	--out thinned-qc-camgwas
cat thinned-qc-camgwas.log >> log.file

# Get the rsIDs of the SNPs in the thinned-qc-camgwas file to use for merging with world pops
#cut -f2 thinned-qc-camgwas.bim > thinned-qc-rs.ids

# Merge thinned qc-data with common SNPs
plink \
	--bfile thinned-qc-camgwas \
	--allow-no-sex \
	--bmerge world \
	--make-bed \
	--flip-scan \
	--out qc-world-merge \
	--extract common-ids.txt
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


rm fo-camgwas* prune* qc-world-merge* thinned-qc-camgwas* 250SB-camgwas*
rm *.log

# Prepare ethnicity template file 
cut -f1 -d' ' merged-data-pruned.fam > cam.id
grep -f cam.id ../../../samples/1471-eth_template.txt > 279cam.eth
grep -f 1kgp.id igsr_pops.txt | cut -f1,3 > 2504world.eth
cat 279cam.eth 2504world.eth > merged-data-eth_template.txt
