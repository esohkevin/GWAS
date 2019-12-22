#!/bin/bash

imputed_path="imputed/"

for chr in {1..22}; do

   if [[ -f "concat_chr"${chr}"_Chunks.txt" || -f "chr"${chr}"_imputed.gen.gz" ]]; then
      rm concat_chr"${chr}"_Chunks.txt chr"${chr}"_imputed.gen.gz chr"${chr}"_imputed.gen
   fi
   if [[ -f "chr${chr}-phased_wref.haps" ]]; then
      for interval in $(cat chr${chr}intervals.txt); do
          echo """chr"${chr}"_"${interval/=*/_imputed.gen.gz}"""" >> concat_chr"${chr}"_Chunks.txt
      done
      for chunk in $(cat concat_chr"${chr}"_Chunks.txt); do
          zcat $chunk | \
            awk '$4=="A" || $4=="T" || $4=="G" || $4=="C"' | \
            awk '$5=="A" || $5=="T" || $5=="G" || $5=="C"' | bgzip -c >> chr"${chr}"_imputed.gen.gz
      done
      #for chunk in $(cat concat_chr"${chr}"_Chunks.txt); do
      #    zcat $chunk | \
      #      awk '$4=="A" || $4=="T" || $4=="G" || $4=="C"' | \
      #      awk '$5=="A" || $5=="T" || $5=="G" || $5=="C"' | \
      #      awk -v chr="$chr" '$1=$2=""; {print "---",chr":"$3,"_"$4,"_"$5,$0}' | \
      #      sed 's/  //g' | \
      #      sed 's/ _A/_A/g' | \
      #      sed 's/ _T/_T/g' | \
      #      sed 's/ _C/_C/g' | \
      #      sed 's/ _G/_G/g' >> chr"${chr}"_imputed.gen
      #done
      #bgzip -i chr"${chr}"_imputed.gen
    fi
done

#--- Check all chunks per chr with successful imputation
for chr in {1..22}; do 
    for chunk in chr${chr}_*_imputed.gen_info; do 
        cat $chunk; 
    done | \
    awk '$4=="A" || $4=="T" || $4=="C" || $4=="G"' | \
    awk '$5=="A" || $5=="T" || $5=="C" || $5=="G"' | \
    awk '$7>=0.75 {print $2}' > chr${chr}_imputed.gen.include
done
