#!/usr/bin/env bash

home="/mnt/lustre/groups/CBBI1243/KEVIN/git/GWAS/"
phase="${home}/phase/"
sb="${phase}sbanimp/"
ba="${phase}banimp"
fm="${phase}5M/"
an="${home}analysis/"
as="${home}assoc_results/"
hm="/home/kesoh/bin/"

for p in sbba sb ba; do for i in sm sma clean; do echo $i; done | parallel echo "--bfile sbba --recode 12 transpose --keep ${p}.{}.cov --threads 24 --keep-allele-order --out ${p}.{}" | xargs -I input -P5 sh -c "plink input"; done
for p in sbba sb ba; do for i in clean sm sma; do echo $i; done | parallel echo 1 ${p}.{} | xargs -n2 -P5 ${as}run_emmax.sh; done
for p in sbba sb ba; do for i in clean sm sma; do mv ${p}.${i}.ps ${p}.${i}.nocov.ps; done; done
for p in sbba sb ba; do for i in clean sm sma; do echo ${i}; done | parallel echo 2 ${p}.{} | xargs -n2 -P5 ${as}run_emmax.sh; done
for p in sbba sb ba; do for i in clean.nocov sm.nocov sma.nocov clean sm sma; do echo ${i}; done | parallel echo ${p}.{}.ps | xargs -n1 -P3 ${an}fdr.R; done
for p in sbba sb ba; do for i in clean.nocov sm.nocov sma.nocov clean sm sma; do echo ${i}; done | parallel echo ${p}.{}.ps sbba.bim | xargs -n2 -P3 ${an}emmax2plink_assoc.R; done
for p in sbba sb ba; do for i in clean.nocov sm.nocov sma.nocov clean sm sma; do echo ${i}; done | parallel echo ${p}.{}.assoc.ps | xargs -n1 -P3 ${an}assoc.R; done
