#!/bin/bash

Rscript prepIndFile.R

sed 's/FID/\#FID/g' ../CONVERTF/qc-world-eth.txt > ../CONVERTF/qc-world-eth.ind
rm ../CONVERTF/qc-world-eth.txt 

smartpca -p par.smartpca-ancmap-eth-fst > smartpca-eth-fst.log
#smartpca -p par.smartpca-pca-grm > smartpca-pca-grm.log
#./../run_twstatsperl
