#!/usr/bin/env bash
plink2="/mnt/lustre/groups/CBBI1243/KEVIN/bioTools/plink2"

for i in *.tfam; do ${plink2} --bfile sbba --glm omit-ref hide-covar --ci 0.95 --adjust --maf 0.01 --geno 0.05 --mind 0.10 --hwe 1e-06 --covar ${i/.tfam/.cov} --autosome --keep ${i} --out ${i/.tfam/}; done
