#!/bin/bash

if [[ $# == 3 ]]; then

base="$1"
bname=$(basename ${base})
admpop="$2"
refpopA="$3"
refpopB="$4"
refpopC="$5"
refpopD="$6"

# ==> alder parameter file <==
echo -e """
genotypename:   ${base}.eigenstratgeno
snpname:        ${base}.snp
indivname:      ${base}-ald.ind
admixpop:       ${admpop}
#refpops:        ${refpopA};${refpopB};${refpopC}
checkmap:       NO
binsize:	0.00000005
nochrom:	6;11
poplistname:	${refpopA}
raw_outname: 	raw.ld.txt
num_threads: 	15

""" > ${bname}-alder.par

else
    echo """
	Usage: ./prep_parfile.sh <input-root (with path)> <pop-label-1> <refpoplistname>
	
		input-root: basename of eigenstrat format files with path to the files
		 pop-label: Population label in 'baseName.ind' file
			 1: for admixpoppulation
		 	 2: for first reference population
			 3: for second reference population
    """

fi
