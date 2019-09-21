#!/bin/bash

analysis="../analysis/"
pop="../popstruct/"

../popstruct/fst/fvcf/

for chr in {1..22}; do
    plink \
        --vcf ${pop}Phased-pca-filtered.vcf.gz \
        --allow-no-sex \
        --pheno "${analysis}"raw-camgwas.fam \
        --update-sex "${analysis}"raw-camgwas.fam 3 \
        --mpheno 4 \
	--maf 0.35 \
        --recode12 \
        --chr ${chr} \
        --double-id \
        --biallelic-only \
        --keep-allele-order \
        --out chr${chr}_phasedWref

    plink2chromopainter.pl \
	-p=chr${chr}_phasedWref.ped \
	-m=chr${chr}_phasedWref.map \
	-o=chr${chr}_phasedWref.phase \
	-d=chr${chr}_phasedWref.cp.sample \
	-g=10e6
done
