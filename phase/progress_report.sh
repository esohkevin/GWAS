#!/bin/bash

phase="$HOME/GWAS/Git/GWAS/phase/"

for i in {1..22}; do echo -e "chr$i: `ls -lh ${phase}chr${i}_*.gen.gz | wc -l`"; done; echo "Total: `ls ${phase}*.gen.gz | wc -l`"
