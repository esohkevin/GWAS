#!/bin/bash

if [[ $# == 6 ]]; then

base="$1"
bname=$(basename ${base})
admpop="$2"
refpopA="$3"
refpopB="$4"
refpopC="$5"
bs="$6"

# ==> alder parameter file <==
echo -e """
genotypename:   ${base}.eigenstratgeno
snpname:        ${base}.snp
indivname:      ${base}-ald.ind
admixpop:       ${admpop}
#refpops:        ${refpopA};${refpopB};${refpopC}
checkmap:       NO
bootstrap: 	300
jackknife:	NO
binsize:	$bs
nochrom:	6;8;11
poplistname:	${refpopA}
raw_outname: 	malder.${admpop}.raw.ld.txt
num_threads: 	15

""" > ${bname}-alder.par

else
    echo """
	Usage: ./prep_parfile.sh <input-root (with path)> <admpop> <p1> <p2> <p3> <binsize>
	
		 input-root: basename of eigenstrat format files with path to the files
		     admpop: for admixpoppulation
		 	 p1: for first reference population OR poplistname (one per line). If provide enter anything on p2 and p3
			 p2: for second reference population
                         p3: for third reference population
                    binsize: genetic distance resolution (in Morgans) at which SNPs are
                             binned for computation and fitting (default=0.0005)
    """

fi
