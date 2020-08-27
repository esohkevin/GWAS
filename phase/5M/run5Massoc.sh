#!/usr/bin/env bash
#
#for i in sban ban sm.cov sma.cov clean.cov; do 
#    plink2 \
#      --bfile imputed \
#      --glm omit-ref sex hide-covar \
#      --covar sb_ba.pca.glm.cov \
#      --covar-name C1 C3 C4 C5 \
#      --ci 0.95 \
#      --out imputed.${i/.*/} \
#      --extract r2_0.75.snp.txt \
#      --keep ${i} \
#      --maf 0.05 \
#      --geno 0.04 \
#      --hwe 1e-06 \
#      --adjust; echo "CHR BP SNP P" > imputed.${i/.*/}; 
#    grep -wv NA imputed.${i/.*/}.PHENO1.glm.logistic | \
#       awk '$7=="ADD" {print $1,$2,$3,$14}' >> imputed.${i/.*/}; ./../../analysis/assoc.R imputed.${i/.*/}; 
#done

for i in sm sma clean; do /mnt/lustre/groups/CBBI1243/KEVIN/bioTools/plink2 --bfile sbba --glm omit-ref sex hide-covar --covar sb_ba.pca.glm.cov --covar-name C1 C3 C4 C5 --maf 0.01 --geno 0.05 --mind 0.10 --hwe 1e-06 --ci 0.95 --out ${i} --keep ${i}.cov --adjust; done
for i in sm sma clean; do for j in hethom recessive dominant; do /mnt/lustre/groups/CBBI1243/KEVIN/bioTools/plink2 --bfile sbba --glm omit-ref sex ${j} hide-covar --covar sb_ba.pca.glm.cov --covar-name C1 C3 C4 C5 --ci 0.95 --out ${i}.${j} --keep ${i}.cov --adjust; done; done
for i in clean sma sm; do echo "CHR SNP BP OR OR_L OR_U P" > ${i}.add.assoc; grep -wv NA ${i}.PHENO1.glm.logistic | sed '1d' | awk '{print $1,$2,$3,$9,$11,$12,$14}' >> ${i}.add.assoc; done
for i in clean sma sm; do echo "CHR SNP BP OR OR_L OR_U P" > ${i}.het.assoc; awk '$7=="HET" {print $1,$2,$3,$9,$11,$12,$14}' ${i}.hethom.PHENO1.glm.logistic | grep -wv NA >> ${i}.het.assoc; done
for i in sm sma clean; do for j in recessive dominant; do echo "CHR SNP BP OR OR_L OR_U P" > ${i}.${j}.assoc; grep -wv NA ${i}.${j}.PHENO1.glm.logistic | sed '1d' | awk '{print $1,$2,$3,$9,$11,$12,$14}' >> ${i}.${j}.assoc; done; done
