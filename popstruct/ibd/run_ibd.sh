#!/bin/bash

if [[ $1 == 1 ]]; then

    #---- One Pop IBD
    hmmIBD \
    	-i pf3k_Cambodia_13.txt \
    	-f freqs_pf3k_Cambodia_13.txt \
    	-o mytest_1pop

elif [[ $1 == 2 ]]; then
    pop1="$2"
    frq1="$3"
    pop2="$4"
    frq2="$5"
    outn="$6"
    #---- Cross-pop IBD
    hmmIBD \
    	-i $pop1 \
    	-f $frq1 \
    	-I $pop2 \
    	-F $frq2 \
    	-o $outn

else
    echo """
	Usage: ./run_ibd.sh <(int) [1|2]> 

	Enter '1' for one population
	      '2' for cross-population (two pops)
    """
fi
