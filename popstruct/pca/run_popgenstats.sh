#!/bin/bash
conda activate eigen
if [[ $# == 4 ]]; then

    gen="$1"
    base="$(basename $gen)"
    poplist="$2"
    odir="$3"
    thr="$4"

echo """genotypename:    ${gen}.eigenstratgeno
snpname:         ${gen}.snp
indivname:       ${gen}.fst.ind
altnormstyle:    NO
ldregress:       200
fstdetailsname:  ${odir}/${base}.fst.snps.txt
fstz:  YES
#fsthiprecision: YES
numthreads:   $thr
#outlieroutname:         ${odir}/${base}.outlier
phylipoutname: ${odir}/${base}.phy
poplistname: $poplist
#killr2: YES
familynames:     NO
#snpweightoutname:       ${odir}/${base}-snpwt
#deletesnpoutname:       ${odir}/${base}-badsnps
fstonly:         YES""" > ${odir}/par.${base}.fst.txt

    echo "smartpca -p ${odir}/par.${base}.fst.txt > ${odir}/${base}.fst.txt"
    smartpca -p ${odir}/par.${base}.fst.txt > ${odir}/${base}.fst.txt
    #sed '1d' $base.fst.snps.txt | awk '$6>0.05 {print $3}' | sort | uniq > ${base}.fstsnps.txt

    #tail -63 fst.${base}.txt | head -30 | awk '$1=""; {print $0}' > temp1.txt

    ##echo "Pop" > temp2.txt
    #grep -w population fst.${base}.txt | awk '{print $3}' > temp2.txt
    #paste temp1.txt temp2.txt > fstMatrix${base}.txt

    #Rscript fstHeatmap.R fstMatrix${base}.txt

else 
    echo """
	Usage:./run_popgen.sh <input_prefix> <pop-list> <out_dir> <threads>

             input_prefix: Prefix of EIGENSTRAT formatted files e.g. CONVERTF/world for CONVERTF/world.eigenstratgeno etc
                  poplist: List containing populations to analyze. NB one population per column
                     e.g. ESN
                          GWD
                          GBR
                          CHB
                  out_dir: Path to write Fst results to e.g. POPGEN/ etc
                  threads: Number of extra threads
    """
fi
