#!/bin/bash

phase_path="$HOME/GWAS/Git/GWAS/phase/"
sample_path="$HOME/GWAS/Git/GWAS/samples/"
# Convert phased haplotypes in vcf format to IMPUTE2 .haps + .sample format

for chr in {1..22}; do
  if [[ -f "${phase_path}""chr${chr}-phased_wref.vcf.gz" ]]; then
     plink2 \
	--vcf "$phase_path"chr"${chr}"-phased_wref.vcf.gz \
	--export haps \
	--double-id \
	--out chr"${chr}"-phased_wref
  else
     echo "chr"${chr}"-phased_wref.vcf.gz was not found!"
  fi
done

