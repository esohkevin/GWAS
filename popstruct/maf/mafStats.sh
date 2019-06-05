#!/bin/bash

world="../eig/world/"

# Extract data for YRI, LWK and study data at MAF>0.1 then compute MAF stats
grep -wi -e cam -e yri -e gwd -e lwk maf-pops.template | awk '{print $1" "$1" "$2}' > camAll.cluster

plink \
       --bfile maf-data \
       --autosome \
       --freq \
       --keep-allele-order \
       --within camAll.cluster \
       --allow-no-sex \
       --out camall

sed 's/:/\t/g' camall.frq.strat > camall.frq.txt
sed 's/SNP/IN\tSNP/g' camall.frq.txt > camall.frq.strat
rm camall.frq.txt
# Observe MAF within Cameroonian populations
plink \
       --bfile maf-data-merge \
       --autosome \
       --freq \
       --keep cam1185.ids \
       --keep-allele-order \
       --within cam1185.eth \
       --allow-no-sex \
       --out cam1185

#### Plot
Rscript mafStats.R

mv *.png ../../images/
