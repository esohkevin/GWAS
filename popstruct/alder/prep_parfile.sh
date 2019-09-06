#!/bin/bash

if [[ $# == 4 ]]; then

base="$1"
bname=$(basename ${base})
admpop="$2"
refpopA="$3"
refpopB="$4"

# ==> alder parameter file <==
echo -e """
genotypename:   ${base}.ancestrymapgeno
snpname:        ${base}.snp
indivname:      ${base}-ald.ind
admixpop:       ${admpop}
refpops:        ${refpopA};${refpopB}
checkmap:       NO

""" > ${bname}-alder.par

else
    echo """
	Usage: ./prep_parfile.sh <input-root (with path)> <pop-label-1> <pop-label-2> <pop-label-3>
	
		input-root: basename of eigenstrat format files with path to the files
		 pop-label: Population label in 'baseName.ind' file
			 1: for admixpoppulation
		 	 2: for first reference population
			 3: for second reference population
    """

fi
