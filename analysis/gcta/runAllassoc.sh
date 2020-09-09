#!/usr/bin/env bash

home="/mnt/lustre/groups/CBBI1243/KEVIN/git/GWAS/"
phase="${home}phase/"
sb="${phase}sbanimp/"
ba="${phase}banimp"
fm="${phase}5M/"
an="${home}analysis/"
as="${home}assoc_results/"
asd="${an}assoc/"
hm="/home/kesoh/bin/"
em="${an}emmax/"
gc="${an}gcta/"
gcta="${HOME}/bin/gcta64"

#--- Make GRM with PLINK2
#for p in sbba sb ba; do echo $p; done | parallel echo "--bfile ${asd}qc-cam --make-grm-bin --keep ${asd}${}.pca.glm.cov --threads 24 --keep-allele-order --maf 0.01 --autosome --out {}" | xargs -I input -P5 sh -c "plink input"; done

#  #-- Generate GCTA pheno files
#  for j in sbba.pca.glm.cov sb.pca.glm.cov ba.pca.glm.cov; do echo "<<< ${j} >>>"; for i in $(awk '{print $1}' ${j}); do grep -w $i ${an}raw-camgwas.sample; done | awk '{print $1,$2,$5}' > ${j/.glm.cov/.grm.pheno}; done
#  for j in sbba.pca.glm.cov sb.pca.glm.cov ba.pca.glm.cov; do echo "<<< ${j} >>>"; for i in $(awk '{print $1}' ${j}); do grep -w $i ${asd}qc-cam.fam; done | awk '{print $1,$2,$5}' > ${j/.pca.glm.cov/.cov.sex}; done
#  
#  #-- Make GRM with GCTA
#  for p in sbba sb ba; do echo $p; done | parallel echo "--bfile ${asd}qc-cam --make-grm ${gc}{} --keep ${gc}{}.pca.grm.pheno --threads 24 --maf 0.01 --autosome --out {}" | xargs -I input -P5 sh -c "${gcta} input"
#  
#  #-- Generate PCs for REML
#  for p in sbba sb ba; do echo $p; done | parallel echo "--grm ${gc}{} --pheno ${gc}{}.pca.grm.pheno --keep ${gc}{}.pca.grm.pheno --threads 24 --pca 50 --maf 0.01 --autosome --out {}" | xargs -I input -P5 sh -c "${gcta} input"

#-- Run REML with eigenvectors
for p in sbba sb ba; do echo $p; done | parallel echo "--grm ${gc}{} --reml --pheno ${gc}{}.pca.grm.pheno --autosome --keep ${gc}{}.pca.grm.pheno --reml-maxit 10000 --reml-alg 0 --qcovar ${gc}{}.pca.grm.cov --covar {}.cov.sex --threads 24 --out {}" | xargs -I input -P5 sh -c "${gcta} input"

#  #-- Run MLMA (association)
#  #gcta64 --bfile ${em}qc-camgwas --mlma --pheno cam.phen --grm cam --out cam --thread-num 24
#  for p in sbba sb ba; do echo $p; done | parallel echo "--bfile ${asd}qc-cam --mlma-loco --grm ${gc}{} --pheno ${gc}{}.pca.grm.pheno --autosome --covar {}.cov.sex --qcovar ${gc}{}.pca.grm.cov --keep ${gc}{}.pca.grm.pheno --threads 24 --out {}" | xargs -I input -P5 sh -c "${gcta} input"

#for i in *.assoc.ps; do echo $i; done | parallel echo ${an}assoc.R {} | xargs -I input -P 10 sh -c "Rscript input"





#---------------------------- In case it is ever necessary -----------------------------------------------------
#  #--- Make GRM with PLINK2
#  #for p in sbba sb ba; do for i in sm sma clean; do echo $i; done | parallel echo "--bfile ${asd}qc-cam --make-grm-bin --keep ${asd}${p}.{}.cov --threads 24 --keep-allele-order --maf 0.01 --autosome --out ${p}.{}" | xargs -I input -P5 sh -c "plink input"; done
#  
#  #-- Generate GCTA pheno files
#  for j in *.id; do echo "<<< ${j} >>>"; for i in $(awk '{print $1}' ${j}); do grep -w $i ${an}qc-camgwas.fam; done | awk '{print $1,$2,$6}' > ${j/.id/.pheno}; done
#  
#  #-- Make GRM with GCTA
#  # for p in sbba sb ba; do for i in sm sma clean; do echo $i; done | parallel echo "--bfile ${an}qc-camgwas --make-grm ${gc}${p}.{} --keep ${gc}${p}.{}.grm.pheno --threads 24 --maf 0.01 --autosome --out ${p}.{}" | xargs -I input -P5 sh -c "${gcta} input"; done
#  
#  #-- Generate PCs for REML
#  for p in sbba sb ba; do for i in sm sma clean; do echo $i; done | parallel echo "--grm ${gc}${p}.{} --pheno ${gc}${p}.{}.grm.pheno --keep ${gc}${p}.{}.grm.pheno --threads 24 --pca 20 --maf 0.01 --autosome --out ${p}.{}" | xargs -I input -P5 sh -c "${gcta} input"; done
#  
#  #-- Run REML with eigenvectors
#  for p in sbba sb ba; do for i in sm sma clean; do echo $i; done | parallel echo "--grm ${gc}${p}.{} --reml --pheno ${gc}${p}.{}.grm.pheno --autosome --keep ${gc}${p}.{}.grm.pheno --qcovar ${p}.{}.eigenvec --threads 24 --out ${p}.{}" | xargs -I input -P5 sh -c "${gcta} input"; done
#  
#  #-- Run MLMA (association)
#  #gcta64 --bfile ${em}qc-camgwas --mlma --pheno cam.phen --grm cam --out cam --thread-num 24
#  for p in sbba sb ba; do for i in sm sma clean; do echo $i; done | parallel echo "--bfile ${an}qc-camgwas --mlma --grm ${gc}${p}.{} --pheno ${gc}${p}.{}.grm.pheno --autosome --qcovar ${p}.{}.eigenvec --keep ${gc}${p}.{}.grm.pheno --threads 24 --out ${p}.{}" | xargs -I input -P5 sh -c "${gcta} input"; done
#  
#  #for i in *.assoc.ps; do echo $i; done | parallel echo ${an}assoc.R {} | xargs -I input -P 10 sh -c "Rscript input"
