#!/bin/bash

for chr in {1..22}; do
    echo "snp_id rs_id position a0 a1 exp_freq_a1 info certainty type info_type0 concord_type0 r2_type0" > chr${chr}Concord.txt; 
    for chunk in chr${chr}_*_imputed.gen_info; do
        awk '$12>0' ${chunk} | grep -v "snp_id" >> chr${chr}Concord.txt
    done
done

cp  chr1Concord.txt mergeConcord.txt

for chr in {2..22}; do sed '1d' chr${chr}Concord.txt >> mergeConcord.txt; done

