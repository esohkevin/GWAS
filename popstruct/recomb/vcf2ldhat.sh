#!/bin/bash

if [[ $# == 2 ]]; then

    in_vcf="$1"
    chr="$2"
    out="$3"

    vcftools \
	--gzvcf ${in_vcf} \
	--chr ${chr} \
	--phased \
	--ldhat \
	--out ${out}chr${chr}

else
    echo """
	Usage: ./vcf2ldhat.sh <in_vcf> <chr#> <out-prefix>
    """

fi
