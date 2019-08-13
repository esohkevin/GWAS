#!/bin/bash

ref_path="1000GP_Phase3/"
imputed_path="imputed/"

if [[ $# == 1 ]]; then

./make_chunks.sh

for chr in 1; do

  if [[ -f "chr${chr}-phased_wref.haps" ]]; then

     rm chr${chr}_chunks.txt

     for interval in `cat chr${chr}intervals.txt`; do

       if [[ ! -f "chr${chr}_${interval/=*/_imputed.gen.gz}" && ! -f "${imputed_path}chr${chr}_${interval/=*/_imputed.gen.gz}" ]]; then
	    echo -e "-use_prephased_g -known_haps_g chr"${chr}"-phased_wref.haps -m "$ref_path"genetic_map_chr"${chr}"_combined_b37.txt -h "$ref_path"1000GP_Phase3_chr"${chr}".hap.gz -l "$ref_path"1000GP_Phase3_chr"${chr}".legend.gz  -int "${interval}" -Ne 20000 -os 0 1 2 3 -buffer 500 -filt_rules_l 'TYPE==\"Biallelic_SNP\"' 'TYPE==\"Biallelic_INDEL\"' -o_gz -o chr"${chr}"_"${interval/=*/_imputed.gen}"\n" >> chr${chr}_imput_chunks.txt
       else
            echo "chr"${chr}"_"${interval/=*/_imputed.gen}" already exists! Its command line has not been included in chr${chr}_chunks.txt file! "
       fi
     done

     sed 's/1=/1 /g' chr${chr}_imput_chunks.txt > chr${chr}_chunks.txt; 		# Primary aim is to create this file for all chrs to use for parallele jod execution
     rm chr${chr}_imput_chunks.txt
   
   else

     echo "chr"${chr}"-phased_wref.haps could not be found!"     

   fi

   cat chr${chr}_chunks.txt | xargs -P$1 -n30 impute_v2.3.2 &			# Run IMPUTE2 with the commands in the files previously created

done

if [[ -f "*.warnings" ]]; then
   rm *_warnings
fi

else
	echo """
	Usage: ./run_impute2.sh <int>
	
	Where <int> is the number of jobs to run per chromosome
"""
fi

#################################################################################################
#												#
#		Original script to run chunks on chromosomes one at a time			#
#		    Should be useful when parallel jobs are impossible				#
#												#
#################################################################################################
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
