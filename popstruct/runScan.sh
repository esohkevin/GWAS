#!/bin/bash

if [[ $# != 4 ]]; then
   echo """
	Usage: ./runScan.sh <in-hap-file> <in-map-file> <out-iHS-plot-name> <iHS-plot-title>
"""
else
   Rscript runScan.R $1 $2 $3
   grep -v -w NA iHSResult.txt | awk '$4>=4' >chr11Signals.txt

   echo """
        Done Scanning Genome! Results saved in iHSResult.txt, frqResults.txt, and chr11Signals.txt
        Please check the 'chr11Signals.txt' file for genomic positions of interest and run the 'runEHH.sh' script for EHH
"""
fi
