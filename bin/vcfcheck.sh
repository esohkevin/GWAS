#!/usr/bin/env bash

read -p "Is each chromosome in a separate file? [yes|no] : " res

if [[ "$res" == "yes" ]];
then
        ref="../human_g1k_v37.fasta"
        vcfbase="qc-camgwas-updated-chr"

	for i in $(seq 1 23);
        do
                echo "`tabix -p vcf "${vcfbase}""${i}".vcf.gz`"
                echo "`bcftools sort "${vcfbase}""${i}".vcf.gz -Oz -o "${vcfbase}""${i}".vcf.gz`"
        done

        for i in $(seq 1 23);
        do
                echo "`checkVCF.py -r "$ref" -o out "${vcfbase}""${i}".vcf.gz`"
        done
elif [[ "$res" == "no" ]];
then
	ref="human_g1k_v37.fasta"
        vcfbase="qc-camgwas-updated"
	echo "`tabix -p vcf "${vcfbase}".vcf.gz`"
	echo "`bcftools sort "${vcfbase}".vcf.gz -Oz -o "${vcfbase}".vcf.gz`"
	echo "`checkVCF.py -r "$ref" -o out "${vcfbase}".vcf.gz`"
	echo "`bcftools index "${vcfbase}".vcf.gz`"
fi

