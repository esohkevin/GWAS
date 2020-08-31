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

for p in sbba sb ba; do for i in sm sma clean; do echo $i; done | parallel echo "--bfile ${em}qc-camgwas --make-grm-bin --keep ${asd}${p}.{}.cov --threads 24 --keep-allele-order --maf 0.01 --autosome --out ${p}.{}" | xargs -I input -P5 sh -c "plink input"; done
for j in *.id; do echo "<<< ${j} >>>"; for i in $(awk '{print $1}' ${j}); do grep -w $i ${em}qc-camgwas.fam; done | awk '{print $1,$2,$6}' > ${j/.id/.pheno}; done

#gcta64 --bfile ${em}qc-camgwas --mlma --pheno cam.phen --grm cam --out cam --thread-num 24
for p in sbba sb ba; do for i in sm sma clean; do echo $i; done | parallel echo "--bfile ${em}qc-camgwas --mlma --grm ${gc}${p}.{} --pheno ${gc}${p}.{}.grm.pheno --autosome --keep ${gc}${p}.{}.grm.pheno --threads 24 --out ${p}.{}" | xargs -I input -P5 sh -c "${gcta} input"; done

#for i in *.assoc.ps; do echo $i; done | parallel echo ${an}assoc.R {} | xargs -I input -P 10 sh -c "Rscript input"
