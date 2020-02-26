#!/usr/bin/env bash

conda activate eigen

for pop in FO BA SB; do
  ./prep_parfile.sh world ${pop} poplistname.txt BA SB 0.0005
  alder -p world-alder.par 2>&1 | tee alder.${pop}.log.out
done
