#!/bin/bash

Rscript prepIndFile.R

sed 's/FID/\#FID/g' ../CONVERTF/qc-world-eth.txt > ../CONVERTF/qc-world-eth.ind
rm ../CONVERTF/qc-world-eth.txt 

smartpca -p par.smartpca-ancmap-eth-fst > smartpca-eth-fst.log
#smartpca -p par.smartpca-pca-grm > smartpca-pca-grm.log
#./../run_twstatsperl

if [[ -f "fstMatrix.txt"]]; then
   rm fstMatrix.txt
fi

if [[ -f "smartpca-eth-fst.log" && -s "smartpca-eth-fst.log" ]]; then
   tail -64 smartpca-eth-fst.log | head -30 | sed '1d' >> tmp2.txt
   tail -65 smartpca-eth-fst.log | head -31 | sed '1d' > tmp2.txt; Rscript -e 'fn <- read.table("tmp2.txt", header=T, as.is=T, row.names=c("SB", "BA", "FO", "GBR", "FIN", "CHS", "PUR", "CDX", "CLM", "IBS", "PEL", "PJL", "KHV", "ACB", "GWD", "ESN", "BEB", "MSL", "STU", "ITU", "CEU", "YRI", "CHB", "JPT", "LWK", "ASW", "MXL", "TSI", "GIH")); write.table(fn[,2:30], file="tmp.txt", col.names=c("SB", "BA", "FO", "GBR", "FIN", "CHS", "PUR", "CDX", "CLM", "IBS", "PEL", "PJL", "KHV", "ACB", "GWD", "ESN", "BEB", "MSL", "STU", "ITU", "CEU", "YRI", "CHB", "JPT", "LWK", "ASW", "MXL", "TSI", "GIH"), row.names=F, quote=F, sep="\t")'; 
   paste tmp1.txt tmp.txt > fstMatrix.txt.txt
   rm tmp2.txt tmp.txt
fi
