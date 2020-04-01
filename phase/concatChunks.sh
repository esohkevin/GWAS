#!/bin/bash

home="$HOME/Git/GWAS/"
imputed_path="${home}allimp/"

if [[ $# != 1 ]]; then
    echo "Usage: concatChunks <info>"
else
   info=$1
   concatChunks() {
      for chr in {1..22}; do
         for chunk in $(ls chr${chr}_*_imputed.gen.gz); do zcat ${chunk}; done | awk '($4=="A" || $4=="T" || $4=="G" || $4=="C") && ($5=="A" || $5=="T" || $5=="G" || $5=="C")' | bgzip -c > chr${chr}_imputed.gen.gz
         for chunk in $(ls chr${chr}_*_imputed.gen_info); do cat ${chunk}; done | awk '($4=="A" || $4=="T" || $4=="G" || $4=="C") && ($5=="A" || $5=="T" || $5=="G" || $5=="C")' > chr${chr}_imputed.gen.info
         awk -v i="$info" '$7>=i {print $2}' chr${chr}_imputed.gen.info > chr${chr}_imputed.gen.include_r2_${info}
      done
   }
fi
