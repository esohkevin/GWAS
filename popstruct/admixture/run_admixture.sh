#!/bin/bash

world="../world/"
convert="../world/CONVERTF/"

# Perform admixture cross-validation to determine the appropriate k value to use
for k in {1..5}; do
	admixture --cv adm-data.bed "${k}" -B300 -j25 | tee log${k}.out;
done

./plotQestimate.sh

