#!/usr/bin/env bash

home="$HOME/Git/GWAS/"
phase="${home}phase/"
sample="${home}samples/"
pop="${home}popstruct/"

vcf="${pop}Phased-pca-filtered.vcf.gz"
sam="${sample}include_bantu-semibantu.txt"
cs=3000000
nc=1
f=1
t=22
i=0.5
gp=0.90
op="3m_imputed"

############################ Run Phasing and Imputation Pipeline ##########################
# Phasing
#./run_wphase_ref.sh

source ${phase}vcf2impute2
source ${phase}makeChunkIntervals
source ${phase}concatChunks 
source ${phase}run_impute2
source ${phase}qct2gen

# Convert Phased VCF to IMPUTE2 .haps and .sample
vcf2impute2 $vcf $sam		# include_semibantu.txt include_bantu.txt exclude_fo.txt  ${pop}Phased-pca-filtered.vcf.gz

# Make chunks
makeChunkIntervals $cs

# Run Imputation
run_impute2 $nc $f $t

# Concatenate Chunks into full chromosomes
concatChunks $i

# Convert GEN file to VCF and PLINK format using qctool and PLINK2
qct2gen $gp phasedWref.sample $op $i
