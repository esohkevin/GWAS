#!/bin/bash

phase="$HOME/GWAS/Git/GWAS/phase/"

for i in {1..22}; do echo -e "chr$i: `ls -lh ${phase}chr${i}_*.gen | wc -l`"; done; echo "Total: `ls ${phase}*.gen | wc -l`"
