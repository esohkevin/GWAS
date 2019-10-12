#!/bin/bash

 imputed_path="imputed/"
 
# for chr in 11; do
# 
#    if [[ -f "concat_chr"${chr}"_Chunks.txt" || -f "chr"${chr}"_imputed.gen.gz" ]]; then
#       rm concat_chr"${chr}"_Chunks.txt chr"${chr}"_imputed.gen.gz chr"${chr}"_imputed.gen
#    fi
# 
#    touch chr"${chr}"_imputed.gen
# 
#   if [[ -f "chr${chr}-phased_wref.haps" ]]; then
# 
#      for interval in $(cat chr${chr}intervals.txt); do
#           echo """chr"${chr}"_"${interval/=*/_imputed.gen.gz}"""" >> concat_chr"${chr}"_Chunks.txt
#      done
# 
#      for chunk in $(cat concat_chr"${chr}"_Chunks.txt); do
#          zcat $chunk | \
#            awk '$4=="A" || $4=="T" || $4=="G" || $4=="C"' | \
#            awk '$5=="A" || $5=="T" || $5=="G" || $5=="C"' | \
#            awk -v chr="$chr" '$1=$2=""; {print "---",chr":"$3,"_"$4,"_"$5,$0}' | \
#            sed 's/  //g' | \
#            sed 's/ _A/_A/g' | \
#            sed 's/ _T/_T/g' | \
#            sed 's/ _C/_C/g' | \
#            sed 's/ _G/_G/g' | uniq >> chr"${chr}"_imputed.gen
#      done
#      bgzip -i chr"${chr}"_imputed.gen
#    fi
# 
# done
# 
# #--- Check all chunks per chr with successful imputation
# for chr in 11; do 
#     for chunk in chr${chr}_*_imputed.gen_info; do 
#         cat $chunk; 
#     done > chr${chr}ImputSuccessful.txt; 
# done

##--- Make file of SNPs with info >= 0.75 to include in VCF file
#for i in {1..22}; do 
#    sed '1d' chr${i}ImputSuccessful.txt | \
#	awk '$7>=0.75' | \
#	awk -v chr="$i" '$1=$2=""; {print chr"\t"$3}' | \
#	sort -n --key=2 | \
#	grep -v position | uniq > chr$i.info75.txt; 
#done

#--- Convert the IMPUTE2 output to VCF
#for i in $(seq 1 22); do echo $i; done | parallel echo convert --threads 10 -G chr{}_imputed.gen.gz,phasedWref.sample -Oz -o chr{}_imputed.vcf.gz | xargs -P22 -n8 bcftools

#--- Extract SNPs with infor >= 0.75
for i in $(seq 1 22); do echo $i; done | parallel echo view --threads 10 -R chr{}.info75.txt -Oz -o temp{}_imputed.vcf.gz chr{}_imputed.vcf.gz | xargs -P22 -n9 bcftools

bcftools view \
  -h temp22_imputed.vcf.gz > imputed_updated.vcf; 
bcftools query \
  -f '%CHROM\t%POS\t%CHROM:%POS\t%REF\t%ALT\t%QUAL\t%FILTER\t.\tGT:GP\t[ %GT:%GP\t]\n' \
  -i 'MAF[0]>0.001' chr{1..22}_imputed.vcf.gz >> imputed_updated.vcf
bgzip imputed_updated.vcf
bcftools sort -m 2000M -Oz -o imputed.vcf.gz imputed_updated.vcf.gz
bcftools index -t -f --threads 30 imputed.vcf.gz

#--- Extract SNPs with infor >= 0.75
#for i in $(seq 1 22); do echo $i; done | parallel echo view --threads 10 -R chr{}.info75.txt -Oz -o temp{}_imputed.vcf.gz chr{}_imputed.vcf.gz | xargs -P22 -n9 bcftools 
#bcftools concat -a -D --threads 30 chr{1..22}_imputed.vcf.gz -Oz -o camgwas_imputed.vcf.gz
