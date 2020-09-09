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
gc="${an}gcta/"
bt="${an}bolt"

# plink --bfile ${asd}qc-cam --indep-pairwise 50 5 0.1 --keep-allele-order --autosome --out pruned
#for p in sbba sb ba; do echo $p; done | parallel echo "--bfile ${asd}qc-cam --make-bed --autosome --keep ${asd}{}.pca.glm.cov --out {}" | xargs -I input -P1 sh -c "plink2 input"
#rm pruned.prune.out

# Compute PCs
#for p in sbba sb ba; do echo $p; done | parallel echo "--bfile {} --make-bed --pca 50 --out {}" | xargs -I input -P1 sh -c "plink2 input"
#for i in *.eigenvec; do sed -i 's/#//g' $i; done
 
# #-- COVs
# for j in ${gc}*.id; do echo "<<< ${j} >>>"; for i in $(awk '{print $1}' ${j}); do grep -w $i ${asd}pca.glm.cov; done | cut -f1,2,4,6-11 -d' ' > $(basename ${j/.grm.id/.blmm.cov}); sed -i '1 i FID IID SEX C1 C2 C3 C4 C5 C6' $(basename ${j/.grm.id/.blmm.cov}); done 

#-- LMM
for p in sbba sb ba; do echo $p; done | parallel echo "--bfile={} --phenoUseFam --covarFile=${asd}sbba.pca.glm.cov --covarMaxLevels=10 --LDscoresUseChip --maxModelSnps=8000000 --numThreads=24 --modelSnps=pruned.prune.in --qCovarCol=PC{1:40} --qCovarCol=SEX --geneticMapFile=${gmap}genetic_map_hg19_withX.txt.gz --lmm --statsFile={}.stats.gz --verboseStats" | xargs -I input -P1 sh -c "${bolt} input"

#-- REML
for p in sbba sb ba; do echo $p; done | parallel echo "--bfile={} --phenoUseFam --covarFile=${asd}sbba.pca.glm.cov --covarMaxLevels=10 --LDscoresUseChip --maxModelSnps=8000000 --numThreads=24 --modelSnps=pruned.prune.in --qCovarCol=SEX --geneticMapFile=${gmap}genetic_map_hg19_withX.txt.gz --reml --statsFile={}.stats.gz --verboseStats" | xargs -I input -P1 sh -c "${bolt} input"


#for p in sbba sb ba; do echo $p; done | parallel echo "--bfile={} --phenoUseFam --covarFile={}.eigenvec --covarMaxLevels=10 --LDscoresUseChip --maxModelSnps=8000000 --numThreads=24 --modelSnps=pruned.prune.in --qCovarCol=PC{1:50} --geneticMapFile=${gmap}genetic_map_hg19_withX.txt.gz --reml --statsFile={}.stats.gz --verboseStats" | xargs -I input -P1 sh -c "${bolt} input"


#for j in *.tfam; do echo "<<< ${j/.tfam/.cov} >>>"; for i in $(awk '{print $1}' ${j}); do grep -w $i ${asd}pca.glm.cov; done > ${j/.tfam/.cov}; done
#for p in sbba sb ba; do for i in clean sm sma; do echo $i; done | parallel echo 1 ${p}.{} | xargs -n2 -P10 ${as}run_emmax.sh; done
#for p in sbba sb ba; do for i in clean sm sma; do mv ${p}.${i}.ps ${p}.${i}.nocov.ps; done; done
#for p in sbba sb ba; do for i in clean sm sma; do echo ${i}; done | parallel echo 2 ${p}.{} | xargs -n2 -P10 ${as}run_emmax.sh; done
#for i in *.ps; do sed -i '1 i SNP\tBETA\tSE\tP' ${i}; done
#for i in *.ps; do echo $i; done | parallel echo ${an}fdr.R {} | xargs -I input -P10 sh -c "Rscript input"
#for i in *.ps.adj.txt; do mv $i ${i/.adj.txt/}; done
#for i in *.ps; do echo $i; done | parallel echo ${an}emmax2plink_assoc.R {} ${em}qc-camgwas.bim | xargs -I input -P10 sh -c "Rscript input"
#for i in *.assoc.ps; do echo $i; done | parallel echo ${an}assoc.R {} | xargs -I input -P 10 sh -c "Rscript input"

