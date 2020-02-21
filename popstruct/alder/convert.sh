#!/bin/bash

plink --vcf alder.vcf.gz --recode --keep-allele-order --maf 0.05 --geno 0.05 --double-id --out world

convertf -p par.PED.PACKEDPED
convertf -p par.PACKEDPED.PACKEDANCESTRYMAP
convertf -p par.PACKEDANCESTRYMAP.ANCESTRYMAP
convertf -p par.ANCESTRYMAP.EIGENSTRAT
