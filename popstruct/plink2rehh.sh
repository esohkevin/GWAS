#!/bin/bash

param="$1"

if [[ "$param" != [123] ]]; then
   
   echo """
	Usage: ./plink2rehh.sh [1|2|3] : Enter '1' if you are working with a specific chromosome region (e.g. chr11:5200-5600)
					       '2' if you are working with a single whole chromosome
					       '3' if you are working with a whole genome with more than one chromosomes
   """
else
   if [[ "$param" == "1" && $# != 7 ]]; then
      echo """
      	Usage: ./plink2rehh.sh 1 <chr#> <from-kb> <to-kb> <pop-name> <genomic-region-name> <input-VCF> (for specific chromosome region)
      """
   elif [[ "$param" == "1" && $# == 7 ]]; then

      # Chr11 HBB 2Mb (5200-5400) region
      plink2 \
      	--chr $2 \
      	--export hapslegend \
      	--vcf $7 \
      	--out chr${2}${5}${6} \
      	--from-kb $3 \
      	--to-kb $4 \
      	--keep $5.txt \
      	--double-id
      
      sed '1d' chr${2}${5}${6}.legend | awk '{print $1"\t""11""\t"$2"\t"$4"\t"$3}' > chr${2}${5}${6}.map
      sed 's/0/2/g' chr${2}${5}${6}.haps > chr${2}${5}${6}.hap
   
   elif [[ "$param" == "2" && $# != 5 ]]; then
      echo """
           Usage: ./plink2rehh.sh 2 <chr#> <pop-name> <input-VCF> (for single whole chromosome)
      """
  
   elif [[ "$param" == "1" && $# == 5 ]]; then

      # Entire chr11
      plink2 \
              --chr $2 \
              --export hapslegend \
              --vcf $4 \
              --out chr$2$3 \
              --keep $3.txt \
              --double-id
     
      sed '1d' chr${2}${3}.legend | awk '{print $1"\t""11""\t"$2"\t"$4"\t"$3}' > chr${2}${3}.map
      sed 's/0/2/g' chr${2}${3}.haps > chr${2}${3}.hap
      
   
   elif [[ "$param" == "3" && $# != 4 ]]; then
      echo """
           Usage: ./plink2rehh.sh 3 <pop-name> <input-VCF> (whole genome with more than one chromosomes)
      """
    elif [[ "$param" == "1" && $# == 4 ]]; then
      # Entire dataset with more than one chromosomes
      plink2 \
              --export hapslegend \
              --vcf $3 \
              --out $2 \
              --keep $2.txt \
              --double-id
     
      sed '1d' ${3}.legend | awk '{print $1"\t""11""\t"$2"\t"$4"\t"$3}' > ${3}.map
      sed 's/0/2/g' ${3}.haps > ${3}.hap
   
   fi

   for file in *.haps *.legend *.log *.sample; do
       if [[ -f ${file} ]]; then
         rm ${file}
       fi
   done

fi
