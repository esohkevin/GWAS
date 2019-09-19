#!/bin/bash

for chr in {1..22}; do
   seq 30 | parallel echo --file boot/cam-{}chr${chr}flk -K 30 --nfit=10 --ncpu=15 -p flkout/cam-{}chr${chr}flk | xargs -P5 -n8 hapflk
done
