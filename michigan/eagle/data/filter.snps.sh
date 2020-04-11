#!/usr/bin/env bash
for i in {1..22}; do zcat chr22.info.gz | awk '>=0.5 {print }' | sed '1d'; done > r2_0.5.snp.txt
