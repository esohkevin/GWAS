#!/usr/bin/env bash

home="$HOME/Git/GWAS/"
ref_path="${home}phase/1000GP_Phase3/"
imputed_path="${home}phase/imputed/"
if [ $# -lt 1 ]; then
   echo "Usage: ./followup_imputation.sh [ chunks_file ]"
else
    f=$1
    for chr in {10..10}; do
      if [[ -f "chr${chr}-phased_wref.haps" ]]; then
       while read -r line; do
       impute_v2.3.2 \
          -use_prephased_g \
          -known_haps_g chr"${chr}"-phased_wref.haps \
          -m "$ref_path"genetic_map_chr"${chr}"_combined_b37.txt \
          -h "$ref_path"1000GP_Phase3_chr"${chr}".hap.gz \
          -l "$ref_path"1000GP_Phase3_chr"${chr}".legend.gz \
          -int 125000001 130000000 \
          -Ne 20000 \
          -buffer 1000 \
          -os 0 1 2 3 \
          -o_gz \
          -filt_rules_l 'TYPE=="Biallelic_INDEL"' 'TYPE=="Biallelic_DEL"' 'TYPE=="Multiallelic_SNP"' 'TYPE=="Multiallelic_INDEL"' 'TYPE=="Multiallelic_CNV"' 'TYPE=="Biallelic_INV"' 'TYPE=="Biallelic_INS:MT"' 'TYPE=="Biallelic_INS:ME:SVA"' 'TYPE=="Biallelic_INS:ME:LINE1"' 'TYPE=="Biallelic_INS:ME:ALU"' 'TYPE=="Biallelic_DUP"' 'AFR==0' \
          -iter 30 \
          -burnin 10 \
          -k 100 \
          -align_by_maf_g \
          -no_sample_qc_info \
          -k_hap 1000 \
          -o chr"${chr}"_follup_imputed2.gen
       done < $f
      else
        echo "chr"${chr}"-phased_wref.haps could not be found!"
      fi
    done
fi
