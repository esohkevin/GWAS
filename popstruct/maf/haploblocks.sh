#!/bin/bash
if [[ $# -lt 1 || $# -gt 1 ]]; then
    echo """	Usage: ./haploblocks.sh <int>  
		where 'int' is the value for the minimum MAF you wish to use
"""
else
    if [[ -f "all$1.blocks.det" || -f "haplo${1}logFile.txt" ]]; then
       rm all$1.blocks.det haplo${1}logFile.txt
    fi

    for pop in cam gwd lwk yri; do
        grep -wi ${pop} maf-pops.template | awk '{print $1" "$1}' > ${pop}.ids

        plink \
	    --bfile maf-data \
	    --blocks no-pheno-req \
	    --blocks-min-maf $1 \
	    --chr 11 \
	    --from-kb 5230 \
	    --to-kb 5300 \
	    --keep ${pop}.ids \
	    --out ${pop}

    echo -e "\n############ <<<<< ${pop} >>>>> #############" >> all$1.blocks.det
    cat ${pop}.blocks.det >> all$1.blocks.det
    cat  ${pop}.log >> haplo${1}logFile.txt
    rm ${pop}.blocks* ${pop}.ids  
    done
rm *.log
fi
