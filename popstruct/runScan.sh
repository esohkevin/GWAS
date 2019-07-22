#!/bin/bash

if [[ $# != 3 ]]; then
   echo """
	Usage: ./runScan.sh <.hap+.map pair basename> <chr#> <pop-name>
"""
else
   Rscript runScan.R $1 $2 $3
#   grep -v -w NA ${3}iHSresult.txt | awk '$4>=4' >chr${2}${3}Signals.txt
#   awk '{print $2}' chr${2}${3}Signals.txt > ${3}sig.pos.txt
#   grep -w -f sig.pos.txt ${1}.map |\
#	   cut -f 1 > signalsRsids.txt

   echo """
        Done Scanning Genome! Results saved in iHSResult.txt, frqResults.txt, and chr11Signals.txt
        Please check the 'chr11Signals.txt' file for genomic positions of interest and run the 'runEHH.sh' script for EHH
"""
   if [[ -f "${3}\*.png" ]]; then
      mv ${3}*.png ../images/
   fi

fi
