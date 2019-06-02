#!/bin/bash

world="../eig/world/"
convert="../eig/world/CONVERTF/"

# Perform admixture cross-validation to determine the appropriate k value to use
for k in {5..7}; do
	admixture --cv adm-data.bed "${k}" -B300 -j25 | tee log${k}.out;
done

./plotQestimate.sh

