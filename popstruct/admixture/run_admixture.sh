#!/bin/bash

world="../world/"
convert="../world/CONVERTF/"

# Perform admixture cross-validation to determine the appropriate k value to use
#for k in {1..5}; do

seq 5 | parallel echo --cv adm-data.bed {} -B300 -j15 | xargs -P5 -n5 admixture

#done

#./plotQestimate.sh

