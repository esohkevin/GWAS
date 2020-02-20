#!/usr/bin/env bash

conda activate eigen

for pop in FO BA SB; do
  ./prep_parfile.sh world ${pop} poplistname.txt BA SB 0.00005
  malder -p world-alder.par 2>&1 | tee malder.${pop}.log.out
done
