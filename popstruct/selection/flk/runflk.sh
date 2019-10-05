#!/bin/bash

p="$1"
prfx="$2"
n="$3"

if [[ $# == 2 && $p == "flk" ]]; then

    #--- Whole Genome flk
    hapflk --bfile boot/${prfx} -p flkout/${prfx}
    Rscript flk.R $prfx

elif [[ $# == 3 && $p == "hflk" ]]; then
        
    #--- Per chromosome hapflk
    seq 22 | parallel echo --bfile boot/cam-chr{}flk -K 30 --kinship flkout/camflk_fij.txt --ncpu=15 -p flkout/cam-chr{}flk | xargs -P5 -n9 hapflk

    #Rscript flk.R

else
    echo """
	Usage:./runflk.sh [flk|hflk] <in-prefix> <n>

		Enter 'flk' to run only whole genome flk or 'hflk' to run only hapflk
		prefix: Input bfile prefix. Do not specify path 
			(input will be takien from /boot and output will be saved in /flkout)
		     n: Number of jobs to run per chromosome (NB: Necessary for 'hapflk' only)
    """
fi
