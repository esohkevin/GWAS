#!/bin/bash

base="qc-camgwas-updated-chr"

vcfCooker --in-bfile qc-camgwas-updated --ref human_g1k_v37.fasta --out qc-camgwas-updated --write-vcf
bgzip -f qc-camgwas-updated.vcf

for i in $(seq 1 23); do
vcfCooker \
	--in-bfile phase/${base}${i} \
	--ref human_g1k_v37.fasta \
	--out phase/${base}${i}.vcf \
	--write-vcf
bgzip -f phase/${base}${i}.vcf
done
