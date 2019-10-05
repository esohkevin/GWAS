#!/bin/bash

imputed_path="imputed/"

for chr in {1..22}; do

if [[ -f "concat_chr"${chr}"_Chunks.txt" || -f "chr"${chr}"_imputed.gen.gz" ]]; then
   rm concat_chr"${chr}"_Chunks.txt chr"${chr}"_imputed.gen.gz
fi

#   rm concat_chr"${chr}"_Chunks.txt
#   rm chr"${chr}"_imputed.gen*
   `touch chr"${chr}"_imputed.gen`


  if [[ -f "chr${chr}-phased_wref.haps" ]]; then

     for interval in $(cat chr${chr}intervals.txt); do

          echo """chr"${chr}"_"${interval/=*/_imputed.gen.gz}"""" >> concat_chr"${chr}"_Chunks.txt

     done

  for chunk in $(cat concat_chr"${chr}"_Chunks.txt); do
      
      zcat ${chunk} >> chr"${chr}"_imputed.gen

  done

      bgzip -i chr"${chr}"_imputed.gen

   fi

done

# Check all chunks per chr with successful imputation
for chr in {1..22}; do 
    
    for chunk in chr${chr}_*_imputed.gen_info; do 
    
        cat $chunk; 
    
    done > chr${chr}ImputSuccessful.txt; 

done
