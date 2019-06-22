#!/bin/bash

# The merged chromosomes file
vcfCooker \
        --in-bfile raw-updated \
        --ref ../analysis/human_g1k_v37.fasta \
        --out raw-updated.vcf \
        --write-vcf
bgzip -f raw-updated.vcf


