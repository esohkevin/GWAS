#!/bin/bash

# Run all scripts in this directory
#for i in ba sb fo; do grep -wi ${i} ../world/cam1073.eth | shuf -n30; done | awk '{print $1,$1}' > cam30.ids
plink --vcf raw-camgwas.vcf.gz --freq --within cam1185.eth --keep-allele-order --double-id --out cam
awk '$7!="0"' cam.frq.strat > cam.frq.strat.txt
