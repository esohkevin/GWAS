#!/bin/bash

for chr in {1..22}; do
    plink2chromopainter.pl \
	-p=chr${chr}_phasedWref.ped \
	-m=chr${chr}_phasedWref.map \
	-o=chr${chr}_phasedWref.phase \
	-d=chr${chr}_phasedWref.cp.sample \
	-g=10e6
done
