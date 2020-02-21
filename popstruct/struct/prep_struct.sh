#!/usr/bin/env bash

#plink \
#   --vcf /home/esoh/Git/GWAS/popstruct/Phased-pca-filtered.vcf.gz \
#   --indep-pairwise 50 10 0.2 \
#   --keep-allele-order \
#   --out prune
#
#plink \
#   --vcf /home/esoh/Git/GWAS/popstruct/Phased-pca-filtered.vcf.gz \
#   --recode structure \
#   --extract prune.prune.in \
#   --keep-allele-order \
#   --maf 0.05 \
#   --double-id \
#   --out /home/esoh/bioTools/console/cam
#
#rm prune*
#rm *.nosex

sed '1,2d' cam.recode.strct_in > cam.gen
head -2 cam.recode.strct_in > cam.struct.in
cut -f3- -d' ' cam.gen > cam.gen.snps
cut -f1-2 -d' ' cam.gen  > cam.gen.col12.txt

Rscript prep_struct.R

paste cam.struct cam.gen.snps | sed 's/\t/ /1' >> cam.struct.in

rm cam.gen cam.gen.snps cam.gen.col12.txt
