#!/usr/bin/env bash

for i in ../phase/5M/sb_ba.pca.glm.cov ../phase/sbanimp/sb.pca.glm.cov ../phase/banimp/ba.pca.glm.cov; do b="$(basename ${i})"; plink2 --bfile qc-camgwas-updated --glm hide-covar sex omit-ref --keep ${i} --out qc-${b/.*/}-additive-nocov --adjust --ci 0.95; done
for i in hethom recessive dominant; do for j in ../phase/5M/sb_ba.pca.glm.cov ../phase/sbanimp/sb.pca.glm.cov ../phase/banimp/ba.pca.glm.cov; do b="$(basename ${j})"; plink2 --bfile qc-camgwas-updated --glm hide-covar sex omit-ref ${i} --keep ${j} --out qc-${b/.*/}-${i}-nocov --adjust --ci 0.95; done; done

#plink2 --bfile qc-camgwas-updated --glm hide-covar sex omit-ref --keep ../phase/5M/sb_ba.pca.glm.cov --out qc-sb_ba-additive-cov --adjust --ci 0.95 --covar ../phase/5M/sb_ba.pca.glm.cov --covar-name C1 C3-C5
#for i in hethom recessive dominant; do plink2 --bfile qc-camgwas-updated --glm hide-covar sex omit-ref ${i} --keep ../phase/5M/sb_ba.pca.glm.cov --out qc-sb_ba-${i}-cov --adjust --ci 0.95 --covar ../phase/5M/sb_ba.pca.glm.cov --covar-name C1 C3-C5; done

