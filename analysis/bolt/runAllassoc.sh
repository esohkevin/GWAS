#!/usr/bin/env bash

home="/mnt/lustre/groups/CBBI1243/KEVIN/git/GWAS/"
boltdir="/mnt/lustre/groups/CBBI1243/KEVIN/bioTools/BOLT-LMM_v2.3.4/"
bolt="${boltdir}bolt"
gmap="${boltdir}tables/"
phase="${home}phase/"
sb="${phase}sbanimp/"
ba="${phase}banimp"
fm="${phase}5M/"
an="${home}analysis/"
as="${home}assoc_results/"
asd="${an}assoc/"
hm="/home/kesoh/bin/"
em="${an}emmax/"

#for p in sbba sb ba; do for i in sm sma clean; do echo $i; done | parallel echo "--bfile ${em}qc-camgwas --recode 12 transpose --keep ${asd}${p}.{}.cov --threads 24 --keep-allele-order --maf 0.01 --autosome --out ${p}.{}" | xargs -I input -P5 sh -c "plink input"; done
#for j in *.tfam; do echo "<<< ${j/.tfam/.cov} >>>"; for i in $(awk '{print $1}' ${j}); do grep -w $i ${asd}pca.glm.cov; done > ${j/.tfam/.cov}; done
#for p in sbba sb ba; do for i in clean sm sma; do echo $i; done | parallel echo 1 ${p}.{} | xargs -n2 -P10 ${as}run_emmax.sh; done
#for p in sbba sb ba; do for i in clean sm sma; do mv ${p}.${i}.ps ${p}.${i}.nocov.ps; done; done
#for p in sbba sb ba; do for i in clean sm sma; do echo ${i}; done | parallel echo 2 ${p}.{} | xargs -n2 -P10 ${as}run_emmax.sh; done
#for i in *.ps; do sed -i '1 i SNP\tBETA\tSE\tP' ${i}; done
#for i in *.ps; do echo $i; done | parallel echo ${an}fdr.R {} | xargs -I input -P10 sh -c "Rscript input"
#for i in *.ps.adj.txt; do mv $i ${i/.adj.txt/}; done
#for i in *.ps; do echo $i; done | parallel echo ${an}emmax2plink_assoc.R {} ${em}qc-camgwas.bim | xargs -I input -P10 sh -c "Rscript input"
for i in *.assoc.ps; do echo $i; done | parallel echo ${an}assoc.R {} | xargs -I input -P 10 sh -c "Rscript input"

bolt --bfile=${bfile} --phenoUseFam --covarFile=${cov} --covarMaxLevels=10 --LDscoresUseChip --maxModelSnps=8000000 --numThreads=4 --modelSnps=pruned.prune.in --qCovarCol=C{1:6} --geneticMapFile=${HOME}/Git/GWAS/phase/tables/genetic_map_hg19_withX.txt.gz --lmmForceNonInf --statsFile=${bfile}.stats.gz --verboseStats
