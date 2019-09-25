#!/bin/bash

if [[ $# == 1 ]]; then

    smartpca -p par.fst.txt > fst$1.txt
    tail -63 fst0.05.txt | head -30 | awk '$1=""; {print $0}' > temp1.txt

    #echo "Pop" > temp2.txt
    grep -w population fst0.05.txt | awk '{print $3}' > temp2.txt
    paste temp1.txt temp2.txt > fstMatrix${1}.txt

    Rscript fstHeatmap.R fstMatrix${1}.txt

else 
    echo """
	Usage:./run_popgen.sh <MAF>
    """
fi
