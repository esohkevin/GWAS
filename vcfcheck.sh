#!/usr/bin/env bash

read -p "Is each chromosome in a separate file? [yes|no] : " res

if [[ "$res" == "yes" ]];
then
        ref="../human_g1k_v37.fasta"
        vcfbase="qc-camgwas-updated-chr"
        for i in $(seq 1 22);
        do
		tabix -p vcf "${vcfbase}""${i}".vcf.gz
		bcftools sort "${vcfbase}""${i}".vcf.gz -Oz -o "${vcfbase}""${i}".vcf.gz
                echo "`checkVCF.py -r "$ref" -o out "${vcfbase}""${i}".vcf.gz`"
        done
elif [[ "$res" == "no" ]];
then
	ref="human_g1k_v37.fasta"
        vcfbase="qc-camgwas-updated"
	tabix -p vcf "${vcfbase}".vcf.gz
	bcftools sort "${vcfbase}".vcf.gz -Oz -o "${vcfbase}".vcf.gz
	echo "`checkVCF.py -r "$ref" -o out "${vcfbase}".vcf.gz`"
fi

