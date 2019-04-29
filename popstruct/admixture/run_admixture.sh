#!/bin/bash

# Perform admixture cross-validation to determine the appropriate k value to use
for k in $(seq 1 5); do
	admixture --cv ../../analysis/qc-camgwas-updated.bed "${k}" | tee log${k}.out;
done

echo -e "\nDone Cross-Validating!"
echo "Please inspect the results and make a choice of k and"
echo "run admixture with your choice"

