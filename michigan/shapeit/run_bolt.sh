#!/bin/bash

for num in {1..22};
do
	for i in merge.filtered-updated-chr${num}; 
	do
		bolt --bfile=${i} --phenoUseFam --reml --numThreads=8 2>&1 | tee ${i/.bim/.log}
	done
done
