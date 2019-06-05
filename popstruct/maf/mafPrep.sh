#!/bin/bash

world="../eig/world/"
analysis="../../analysis/"

cut -f2 ${world}worldPops/phased-data-updated.bim > phased.rsids

if [[ -f "merge.list" || -f "logFile.txt" ]]; then
   rm merge.list logFile.txt
fi

for pop in cam yri gwd lwk; do 
    grep -wi ${pop} maf-pops.template | awk '{print $1" "$1}' > ${pop}.ids
    plink \
        --bfile ${world}worldPops/qc-world-merge \
        --keep-allele-order \
	--extract phased.rsids \
        --thin-indiv-count 99 \
        --keep ${pop}.ids \
        --make-bed \
        --out ${pop}99
cat ${pop}99.log >> logFile.txt

    echo ${pop}99 >> merge.list
    rm ${pop}.ids
done

plink \
        --merge-list merge.list \
        --keep-allele-order \
        --out maf-data
cat maf-data.log >> logFile.txt

./mafStats.sh
# Extract only SNPs with rsIDs
#plink \
#        --bfile ${world}worldPops/qc-world-merge \
#        --allow-no-sex \
#	--maf 0.01 \
#	--keep-allele-order \
#        --extract phased.rsids \
#        --make-bed \
#        --out maf-data

#cut -f2 maf-data.bim > maf-data.rsids

rm *99* 
