#!/usr/bin/env bash

home="/mnt/lustre/groups/CBBI1243/KEVIN/git/GWAS/"
phase="${home}/phase/"
sb="${phase}sbanimp/"
ba="${phase}banimp"
fm="${phase}5M/"
an="${home}analysis/"
as="${home}assoc_results/"
hm="/home/kesoh/bin/"

for p in sbba sb ba; do for i in sm sma clean; do echo $i; done | parallel echo "--bfile sbba --recode 12 transpose --keep ${p}.{}.cov --threads 24 --keep-allele-order --autosome --maf 0.01 --geno 0.05 --mind 0.10 --hwe 1e-06 --out ${p}.{}" | xargs -I input -P5 sh -c "plink input"; done
for j in *.tfam; do echo "<<< ${j/.tfam/.cov} >>>"; for i in $(awk '{print $1}' ${j}); do grep -w $i ${fm}sb_ba.pca.glm.cov; done > ${j/.tfam/.cov}; done
for p in sbba sb ba; do for i in clean sm sma; do echo $i; done | parallel echo 1 ${p}.{} | xargs -n2 -P10 ${as}run_emmax.sh; done
for p in sbba sb ba; do for i in clean sm sma; do mv ${p}.${i}.ps ${p}.${i}.nocov.ps; done; done
for p in sbba sb ba; do for i in clean sm sma; do echo ${i}; done | parallel echo 2 ${p}.{} | xargs -n2 -P10 ${as}run_emmax.sh; done
for i in *.ps; do sed -i '1 i SNP\tBETA\tSE\tP' ${i}; done
for i in *.ps; do echo $i; done | parallel echo ${an}fdr.R {} | xargs -I input -P10 sh -c "Rscript input"
for i in *.ps.adj.txt; do mv $i ${i/.adj.txt/}; done
for i in *.ps; do echo $i; done | parallel echo ${an}emmax2plink_assoc.R {} sbba.bim | xargs -I input -P10 sh -c "Rscript input"
for i in *.assoc.ps; do echo $i; done | parallel echo assoc.R {} | xargs -I input -P 10 sh -c "Rscript input"
