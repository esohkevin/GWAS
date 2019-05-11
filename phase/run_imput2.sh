#!/bin/bash

ref_path="1000GP_Phase3/"

for chr in {1..22}; do
  if [[ -f "chr${chr}_phased_wref.haps" ]]; then
   impute_v2.3.2 \
      -use_prephased_g \
      -known_haps_g chr"${chr}"_phased_wref.haps \
      -m "$ref_path"genetic_map_chr"${chr}"_combined_b37.txt \
      -h "$ref_path"1000GP_Phase3_chr"${chr}".hap.gz \
      -l "$ref_path"1000GP_Phase3_chr"${chr}".legend.gz \
      -int 202658471 204658471 \
      -Ne 20000 \
      -buffer 1000 \
      -o chr"${chr}"_test1_imput2.gen
  else
    echo "chr"${chr}"_phased_wref.haps could not be found!"
  fi
done
