#!/usr/bin/env bash

for i in ba sb fo; do grep -i ${i} ../world/cam1073.eth | shuf -n 30; done | awk '{print $1,$1}' > cam30.ids

#plink \
#   --vcf ${HOME}/Git/GWAS/popstruct/Phased-pca-filtered.vcf.gz \
#   --indep-pairwise 50 10 0.2 \
#   --keep-allele-order \
#   --extract ../eig/POPGEN/fstsnps.txt \
#   --out prune

#   --extract prune.prune.in \
#   --maf 0.05 \
#   --keep cam30.ids \
 
plink \
   --vcf ${HOME}/Git/GWAS/popstruct/Phased-pca-filtered.vcf.gz \
   --recode structure \
   --extract ../eig/POPGEN/fstsnps.txt \
   --keep-allele-order \
   --maf 0.35 \
   --double-id \
   --out cam

#rm prune*
rm *.nosex

sed '1,2d' cam.recode.strct_in > cam.gen
head -2 cam.recode.strct_in > cam.struct.in
cut -f3- -d' ' cam.gen > cam.gen.snps
cut -f1-2 -d' ' cam.gen  > cam.gen.col12.txt

Rscript prep_struct.R

paste cam.struct cam.gen.snps | \
   sed 's/\t/ /1' | \
   sed 's/BA/1/1' | \
   sed 's/SB/2/1' | \
   sed 's/FO/3/1' >> cam.struct.in

rm cam.gen cam.gen.snps cam.gen.col12.txt
