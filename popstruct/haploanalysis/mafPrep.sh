#!/bin/bash

world="../eig/world/worldPops/"
analysis="../../analysis/"
sample="../../samples/"

#if [[ -f "worldMergeList.txt" ]]; then
#    rm worldMergeList.txt
#fi

plink \
        --bfile ${world}../cam-controls \
        --keep-allele-order \
        --keep ${sample}cam.ids \
        --remove fulbe.txt \
        --make-bed \
        --maf 0.0001 \
        --out cam

#echo "cam" > worldMergeList.txt
#
#for pop in gwd lwk yri esn msl; do
#    plink \
#        --bfile ${world}world-pops-updated \
#        --keep ${sample}${pop}.ids \
#        --keep-allele-order \
#        --out ${pop} \
#        --make-bed \
#        --update-sex ${world}update-1kgp.sex 1 \
#        --maf 0.0001
#
#        echo ${pop} >> worldMergeList.txt
#done

plink \
        --merge-list worldMergeList.txt \
        --keep-allele-order \
        --out world

./mafWorld.sh 11 5200 5400 HBB
