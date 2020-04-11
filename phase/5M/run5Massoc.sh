#!/usr/bin/env bash

for i in sban ban sm.cov sma.cov clean.cov; do 
    plink2 \
      --bfile imputed \
      --glm omit-ref sex hide-covar \
      --covar sb_ba.pca.glm.cov \
      --covar-name C1 C3 C4 C5 \
      --ci 0.95 \
      --out imputed.${i/.*/} \
      --extract r2_0.75.snp.txt \
      --keep ${i} \
      --maf 0.05 \
      --geno 0.04 \
      --hwe 1e-06 \
      --adjust; echo "CHR BP SNP P" > imputed.${i/.*/}; 
    grep -wv NA imputed.${i/.*/}.PHENO1.glm.logistic | \
       awk '$7=="ADD" {print $1,$2,$3,$14}' >> imputed.${i/.*/}; ./../../analysis/assoc.R imputed.${i/.*/}; 
done

for i in sm.cov sma.cov clean.cov; do plink2 --bfile imputed --glm omit-ref sex hethom hide-covar --covar sb_ba.pca.glm.cov --covar-name C1 C3 C4 C5 --ci 0.95 --out imputed.het.${i/.*/} --keep ${i} --maf 0.05 --geno --hwe 1e-06 --adjust; done
for i in clean sma sm; do echo "CHR BP SNP OR P" > ${i}.het.assoc; awk '$7=="HET" {print $1,$2,$3,$9,$14}' imputed.het.${i}.PHENO1.glm.logistic | grep -wv NA | sort -g -k5 >> ${i}.het.assoc; done
