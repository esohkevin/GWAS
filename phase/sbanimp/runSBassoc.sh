#!/usr/bin/env bash

for i in sm.cov sma.cov clean.cov; do plink2 --bfile imputed --glm omit-ref sex hide-covar --covar sb.pca.glm.cov --covar-name C1 C3 --ci 0.95 --out imputed.${i/.*/} --extract r2_0.75.snp.txt --keep ${i} --maf 0.05 --geno 0.05 --hwe 1e-06 --adjust; echo "CHR BP SNP OR P" > imputed.${i/.*/}; grep -wv NA imputed.${i/.*/}.PHENO1.glm.logistic | awk '$7=="ADD" {print $1,$2,$3,$9,$14}' >> imputed.${i/.*/}; ./../../analysis/assoc.R imputed.${i/.*/}; done
