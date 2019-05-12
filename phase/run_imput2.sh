#!/bin/bash

ref_path="1000GP_Phase3/"

for chr in {1..22}; do

  if [[ -f "chr${chr}-phased_wref.haps" ]]; then

     rm chr${chr}_chunks.txt

     for interval in `cat chr${chr}intervals.txt`; do
	echo -e """-use_prephased_g -known_haps_g chr"${chr}"-phased_wref.haps -m "$ref_path"genetic_map_chr"${chr}"_combined_b37.txt -h "$ref_path"1000GP_Phase3_chr"${chr}".hap.gz -l "$ref_path"1000GP_Phase3_chr"${chr}".legend.gz  -int "${interval}" -Ne 20000 -buffer 500 -o chr"${chr}"_"${interval/=*/_imputed.gen}"\n""" >> chr${chr}_imput_chunks.txt
     done

     sed 's/=/ /g' chr${chr}_imput_chunks.txt > chr${chr}_chunks.txt; # Primary aim is to create this file for all chrs to use for parallele jod execution
     rm chr${chr}_imput_chunks.txt
   
    else

     echo "chr"${chr}"-phased_wref.haps could not be found!"     

   fi

   # Run IMPUTE2 with the commands in the files previously created
   cat chr${chr}_chunks.txt | xargs -P2 -n30 impute_v2.3.2 &

done



     # Run IMPUTE2 with the commands in the files previously created
#     cat chr${chr}_chunks.txt | xargs -P6 -n12 impute_v2.3.2 &

#for chr in {1..22}; do

#    for param in `cat chr${chr}_chunks.txt`; do
#         impute_v2.3.2 $param
#    done

#done






#for chr in {1..22}; do
#  if [[ -f "chr${chr}-phased_wref.haps" ]]; then
#   impute_v2.3.2 \
#      -use_prephased_g \
#      -known_haps_g chr"${chr}"-phased_wref.haps \
#      -m "$ref_path"genetic_map_chr"${chr}"_combined_b37.txt \
#      -h "$ref_path"1000GP_Phase3_chr"${chr}".hap.gz \
#      -l "$ref_path"1000GP_Phase3_chr"${chr}".legend.gz \
#      -int '160000000 162000000' \
#      -Ne 17469 \
#      -buffer 1000 \
#      -o chr"${chr}"_imputed2.gen
#  else
#    echo "chr"${chr}"-phased_wref.haps could not be found!"
#  fi
#done
