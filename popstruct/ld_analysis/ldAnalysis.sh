#!/bin/bash

analysis="../../analysis/"

plink \
	--bfile ${analysis}qc-camgwas-updated \
        --r2 \
	--chr 4 \
	--from-bp 144000000 \
	--to-bp 146000000 \
        --ld-window-kb 22 \
        --ld-window 10 \
        --ld-window-r2 0.2 \
	--out gypchr4
