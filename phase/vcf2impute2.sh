#!/bin/bash

phase_path="$HOME/GWAS/Git/GWAS/phase/"

# Convert phased haplotypes in vcf format to IMPUTE2 .haps + .sample format

for chr in chr{1..22}-phased_wref.vcf.gz; do
  if [[ -f "${phase_path}""${chr}" ]]; then
     plink2 \
	--vcf "$phase_path""${chr}" \
	--export haps \
	--double-id \
	--out chr1_phased_wref
  else
     echo "${chr} was not found!"
  fi
done

