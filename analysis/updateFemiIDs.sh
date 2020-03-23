#!/bin/bash

#for i in {1..22} MT X Y; do 
#    echo -e "chr${i}\t${i/T/}"; 
#done > ucsc2plink.txt

#zcat joint_call_new.vcf.gz | sed 's/chrM/M/g' | sed 's/chr//g' | bgzip -c > joint_call_new2.vcf.gz                                                        
#tabix -f -p vcf joint_call_new2.vcf.gz
#bcftools sort -m 2000M joint_call_new2.vcf.gz -Oz -o joint_call_new2.vcf.gz

plink --vcf joint_call_new2_updated.vcf.gz --make-bed --aec --allow-no-sex --double-id --out joint

cut -f1,4 joint.bim | \
        sed 's/\t/:/g' > joint.pos
cut -f2 joint.bim > joint.ids
paste joint.ids joint.pos > joint-ids-pos.txt

plink \
        --bfile joint \
        --update-name joint-ids-pos.txt 2 1 \
        --allow-no-sex \
        --make-bed \
        --out joint

plink \
        --bfile joint \
        --update-name updateName.txt 1 2 \
        --allow-no-sex \
        --make-bed \
        --out joint

