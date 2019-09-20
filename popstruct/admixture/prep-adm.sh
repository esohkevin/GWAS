#!/bin/bash

analysis="../../analysis/"
samples="../../samples/"
kgp="../../1000G/"
world="../eig/world/"
phase="../../phase/"

# Extract only a subset of world Pops to use (YRI+LWK+GWD+GBR+CHS+BEB+PUR). 
# The ids are stored in worldPops.ids
#cat cam.ids yri.ids adm.txt > adm.pops
#cut -f2 ${world}yri.bim > yri.rsids

if [[ $# == 1 ]]; then

    in_vcf="$1"
    
    plink \
        --vcf ${in_vcf} \
        --allow-no-sex \
        --autosome \
	--double-id \
	--extract fstsnps.txt \
    	--indiv-sort f adm.order \
    	--make-bed \
        --out temp
    
    # Prune to get only SNPs at linkage equilibrium (independent SNPs - no LD between them)
    plink \
    	--bfile temp \
    	--indep-pairwise 50 10 0.2 \
    	--allow-no-sex \
    	--out prune
    cat prune.log >> log.file
    
    plink \
    	--bfile temp \
    	--autosome \
    	--maf 0.01 \
	--hwe 1e-8 \
    	--extract prune.prune.in \
    	--make-bed \
    	--out adm-data
    
    rm temp*

# Prepare .pop file
Rscript prep-adm.R

else
    echo """
	Usage:./prep-adm.sh <in_vcf>
    """

fi

