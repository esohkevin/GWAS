#!/usr/bin/env bash

home="${HOME}/Git/GWAS/phase/"
sb="${home}sbanimp/"
ba="${home}banimp"
fm="${home}5M/"
an="${HOME}/Git/GWAS/analysis/"
as="${HOME}/Git/GWAS/assoc_results/"

#for i in sm sma clean; do echo $i; done | parallel echo "--bfile imputed --recode 12 transpose --extract r2_0.85.snp.txt --geno 0.05 --hwe 1e-06 --keep {}.cov  --maf 0.03 --threads 30 --keep-allele-order --out {}" | xargs -I input -P5 sh -c "plink input"
#for i in clean sm sma; do echo $i; done | parallel echo 1 {} | xargs -n2 -P5 ${as}run_emmax.sh
#for i in clean sm sma; do mv ${i}.ps ${i}.nocov.ps; done
for i in clean sm sma; do echo $i; done | parallel echo 2 {} | xargs -n2 -P5 ${as}run_emmax.sh
for i in clean.nocov sm.nocov sma.nocov clean sm sma; do echo $i; done | parallel echo {}.ps | xargs -n1 -P3 ${an}fdr.R
for i in clean.nocov sm.nocov clean sm sma; do echo $i; done | parallel echo {}.ps imputed.bim | xargs -n2 -P3 ${an}emmax2plink_assoc.R
for i in clean.nocov sm.nocov clean sm sma; do echo $i; done | parallel echo {}.assoc.ps | xargs -n1 -P3 ${an}assoc.R
