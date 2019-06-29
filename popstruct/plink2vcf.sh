#!/bin/bash

# The merged chromosomes file
vcfCooker \
        --in-bfile cam11-updated \
        --ref ../analysis/human_g1k_v37.fasta \
        --out cam11-updated.vcf \
        --write-vcf
bgzip -f cam11-updated.vcf


