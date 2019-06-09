#!/bin/bash

world="../eig/world/"

if [[ $# -lt 5 || $# -gt 5 ]]; then
    echo """    Usage: ./mafStats.sh <chr#> <from-kb> <to-kb> <gene-name> <blocks-min-maf>
                where 'blocks-min-maf' is the value for the minimum MAF you wish to use for haploblock
"""
else

    # Extract data for YRI, LWK and study data at MAF>0.1 then compute MAF stats
    grep -wi -e cam -e yri -e gwd -e lwk -e ibs -e chb maf-pops.template | awk '{print $1" "$1" "$2}' > camAll.cluster
    
    plink \
        --bfile maf-data \
    	--chr $1 \
    	--from-kb $2 \
    	--to-kb $3 \
        --freq \
	--geno 0.01 \
        --keep-allele-order \
        --within camAll.cluster \
        --allow-no-sex \
        --out all$4
    
    head -1 all$4.frq.strat > afr$4.frq.strat; grep -wi -e cam -e gwd -e yri -e lwk all$4.frq.strat >> afr$4.frq.strat
    
    #sed 's/:/\t/g' camall.frq.strat > camall.frq.txt
    #sed 's/SNP/IN\tSNP/g' camall.frq.txt > camall.frq.strat
    #rm camall.frq.txt
    #
    ## Observe MAF within Cameroonian populations
    #plink \
    #       --bfile maf-data-merge \
    #       --autosome \
    #       --freq \
    #       --keep cam1185.ids \
    #       --keep-allele-order \
    #       --within cam1185.eth \
    #       --allow-no-sex \
    #       --out cam1185
    #
    ##### Plot
    #Rscript mafStats.R
    #
    #mv *.png ../../images/i
    #
    #rm *.log
    
    ./haploblocks.sh $1 $2 $3 $4 $5
fi
