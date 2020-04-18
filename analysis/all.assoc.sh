#!/usr/bin/env bash
plink2="/mnt/lustre/groups/CBBI1243/KEVIN/bioTools/plink2"

#-- Without covariates
for i in 5M sbanimp banimp; do echo $i; done | \
    parallel echo "--bfile qc-camgwas-updated --glm hide-covar sex omit-ref --keep ../phase/{}/{}.cov --out qc-{}-additive-nocov --adjust --autosome --ci 0.95" | \
    xargs -I input -P5 sh -c "${plink2} input" &

for i in hethom recessive dominant; do
    for j in 5M sbanimp banimp; do echo $j; done | \
        parallel echo "--bfile qc-camgwas-updated --glm hide-covar sex omit-ref ${i} --keep ../phase/{}/{}.cov --out qc-{}-${i}-nocov --adjust --autosome --ci 0.95" | \
       xargs -I input -P5 sh -c "${plink2} input" &

done

for i in 5M sbanimp banimp; do plink2 --bfile qc-camgwas-updated --glm hide-covar sex omit-ref --keep ../phase/${i}/${i}.cov --out qc-${i}-additive-nocov --adjust --autosome --ci 0.95; done
for i in hethom recessive dominant; do for j in 5M sbanimp banimp; do plink2 --bfile qc-camgwas-updated --glm hide-covar sex omit-ref ${i} --keep ../phase/${j}/${j}.cov --out qc-${j}-${i}-nocov --adjust --autosome --ci 0.95; done; done

#-- With covariates
plink2 --bfile qc-camgwas-updated --glm hide-covar sex omit-ref --keep ../phase/5M/sb_ba.pca.glm.cov --out qc-sb_ba-additive-cov --adjust --autosome --ci 0.95 --covar ../phase/5M/sb_ba.pca.glm.cov --covar-name C1 C3-C5
for i in hethom recessive dominant; do plink2 --bfile qc-camgwas-updated --glm hide-covar sex omit-ref ${i} --keep ../phase/5M/sb_ba.pca.glm.cov --out qc-sb_ba-${i}-cov --adjust --autosome --ci 0.95 --covar ../phase/5M/sb_ba.pca.glm.cov --covar-name C1 C3-C5; done

plink2 --bfile qc-camgwas-updated --glm hide-covar sex omit-ref --keep ../phase/sbanimp/sb.pca.glm.cov --out qc-sb-additive-cov --adjust --autosome --ci 0.95 --covar ../phase/sbanimp/sb.pca.glm.cov --covar-name C1 C3
for i in hethom recessive dominant; do plink2 --bfile qc-camgwas-updated --glm hide-covar sex omit-ref ${i} --keep ../phase/sbanimp/sb.pca.glm.cov --out qc-sb-${i}-cov --adjust --autosome --ci 0.95 --covar ../phase/sbanimp/sb.pca.glm.cov --covar-name C1 C3; done

plink2 --bfile qc-camgwas-updated --glm hide-covar sex omit-ref --keep ../phase/banimp/ba.pca.glm.cov --out qc-ba-additive-cov --adjust --autosome --ci 0.95 --covar ../phase/banimp/ba.pca.glm.cov --covar-name C1-C3 C9
for i in hethom recessive dominant; do plink2 --bfile qc-camgwas-updated --glm hide-covar sex omit-ref ${i} --keep ../phase/banimp/ba.pca.glm.cov --out qc-ba-${i}-cov --adjust --autosome --ci 0.95 --covar ../phase/banimp/ba.pca.glm.cov --covar-name C1-C3 C9; done

#-- SM, SMA
#-- Without covariates
#for i in 5M sbanimp banimp; do echo $i; done | \
#    parallel echo "--bfile qc-camgwas-updated --glm hide-covar sex omit-ref --keep ../phase/{}/{}.cov --out qc-{}-additive-nocov --adjust --autosome --ci 0.95" | \
#    xargs -I input -P5 sh -c "${plink2} input" 
#
#for i in hethom recessive dominant; do 
#    for j in 5M sbanimp banimp; do echo $j; done | \
#        parallel echo "--bfile qc-camgwas-updated --glm hide-covar sex omit-ref ${i} --keep ../phase/{}/{}.cov --out qc-{}-${i}-nocov --adjust --autosome --ci 0.95" | \
#       xargs -I input -P5 sh -c "${plink2} input" 
# 
#done

#for i in ../phase/5M/sb_ba.pca.glm.cov ../phase/sbanimp/sb.pca.glm.cov ../phase/banimp/ba.pca.glm.cov; do b="$(basename ${i})"; plink2 --bfile qc-camgwas-updated --glm hide-covar sex omit-ref --keep ${i} --out qc-${b/.*/}-additive-nocov --adjust --autosome --ci 0.95; done
#for i in hethom recessive dominant; do for j in ../phase/5M/sb_ba.pca.glm.cov ../phase/sbanimp/sb.pca.glm.cov ../phase/banimp/ba.pca.glm.cov; do b="$(basename ${j})"; plink2 --bfile qc-camgwas-updated --glm hide-covar sex omit-ref ${i} --keep ${j} --out qc-${b/.*/}-${i}-nocov --adjust --autosome --ci 0.95; done; done
#
##-- With covariates
#plink2 --bfile qc-camgwas-updated --glm hide-covar sex omit-ref --keep ../phase/5M/sb_ba.pca.glm.cov --out qc-sb_ba-additive-cov --adjust --autosome --ci 0.95 --covar ../phase/5M/sb_ba.pca.glm.cov --covar-name C1 C3-C5
#for i in hethom recessive dominant; do plink2 --bfile qc-camgwas-updated --glm hide-covar sex omit-ref ${i} --keep ../phase/5M/sb_ba.pca.glm.cov --out qc-sb_ba-${i}-cov --adjust --autosome --ci 0.95 --covar ../phase/5M/sb_ba.pca.glm.cov --covar-name C1 C3-C5; done
#
#plink2 --bfile qc-camgwas-updated --glm hide-covar sex omit-ref --keep ../phase/sbanimp/sb.pca.glm.cov --out qc-sb-additive-cov --adjust --autosome --ci 0.95 --covar ../phase/sbanimp/sb.pca.glm.cov --covar-name C1 C3
#for i in hethom recessive dominant; do plink2 --bfile qc-camgwas-updated --glm hide-covar sex omit-ref ${i} --keep ../phase/sbanimp/sb.pca.glm.cov --out qc-sb-${i}-cov --adjust --autosome --ci 0.95 --covar ../phase/sbanimp/sb.pca.glm.cov --covar-name C1 C3; done
#
#plink2 --bfile qc-camgwas-updated --glm hide-covar sex omit-ref --keep ../phase/banimp/ba.pca.glm.cov --out qc-ba-additive-cov --adjust --autosome --ci 0.95 --covar ../phase/banimp/ba.pca.glm.cov --covar-name C1-C3 C9
#for i in hethom recessive dominant; do plink2 --bfile qc-camgwas-updated --glm hide-covar sex omit-ref ${i} --keep ../phase/banimp/ba.pca.glm.cov --out qc-ba-${i}-cov --adjust --autosome --ci 0.95 --covar ../phase/banimp/ba.pca.glm.cov --covar-name C1-C3 C9; done



