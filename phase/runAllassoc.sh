#!/usr/bin/env bash

home="${HOME}/Git/GWAS/phase/"
sb="${home}sbanimp/"
ba="${home}banimp"
fm="${home}5M/"
an="${HOME}/Git/GWAS/analysis/"
as="${HOME}/Git/GWAS/assoc_results/"

for i in $sb $ba $fm; do 
   cd $i 
   #for i in clean sm sma; do echo sma; done | parallel echo 2 {} | xargs -n2 -P5 ${as}assoc_results/run_emmax.sh
   #for i in clean sm sma; do echo sma; done | parallel echo {}.ps | xargs -n1 -P3 ${an}fdr.R
   #for i in clean sm sma; do echo sma; done | parallel echo {}.ps imputed.bim | xargs -n2 -P3 ${an}emmax2plink_assoc.R
   for i in clean sm sma; do echo sma; done | parallel echo {}.assoc.ps | xargs -n1 -P9 ${an}assoc.R
done
