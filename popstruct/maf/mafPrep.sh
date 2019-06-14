#!/bin/bash

world="../eig/world/"
analysis="../../analysis/"
sample="../../samples/"

#cut -f2 ${world}worldPops/phased-data-updated.bim > phased.rsids

#if [[ -f "merge.list" || -f "logFile.txt" ]]; then
#   rm merge.list logFile.txt
#fi
#
#for pop in cam yri gwd lwk ibs chb; do 
#    plink \
#        --bfile ${pop}worldPops/camMergeSet \
#        --keep-allele-order \
#        --thin-indiv-count 99 \
#        --keep ${sample}"${pop}".ids \
#        --make-bed \
#        --out ${pop}99
#
#    echo ${pop}99 >> merge.list
#done
#
#plink \
#        --merge-list merge.list \
#        --keep-allele-order \
#        --out maf-data
#
## Extract only SNPs with rsIDs
##plink \
##        --bfile ${world}worldPops/qc-world-merge \
##        --allow-no-sex \
##	--maf 0.01 \
##	--keep-allele-order \
##        --extract phased.rsids \
##        --make-bed \
##        --out maf-data
#
#rm *99*

plink \
	--vcf ../../phase/Phased_wref.vcf.gz \
	--make-bed \
	--keep-allele-order \
	--biallelic-only \
	--pheno ../../analysis/qc-camgwas-updated.fam \
	--mpheno 4 \
	--update-sex ../../analysis/qc-camgwas-updated.fam 3 \
	--double-id \
	--out camgwasPhasedWref

