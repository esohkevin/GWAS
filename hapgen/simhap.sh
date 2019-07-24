#!/bin/bash

hapgen2 \
	-m ../phase/1000GP_Phase3/genetic_map_chr11_combined_b37.txt \
	-l chr11.legend \
	-h chr11.haps \
	-n 1000 1000 \
	-dl 56216495 0 1 1 \
	-no_gens_output \
	-Ne 17469 \
	-o chr11.out

sed '1d' chr11.out.legend | awk '{print $1"\t""11""\t"$2"\t"$4"\t"$3}' > chr11con.map
sed 's/0/2/g' chr11.out.controls.haps > chr11con.hap
