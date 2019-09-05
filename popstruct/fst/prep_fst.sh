#!/bin/bash

in_vcf="$1"

plink \
	--vcf ${in_vcf} \
	--maf 0.05 \
	--
