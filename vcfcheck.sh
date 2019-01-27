#!/usr/bin/env bash

read -p "Is each chromosome in a separate file? [yes|no] : " res

if [[ "$res" == [yY] || "$res" == "yes" || "$res" == "YES" ]];
then
	echo -e "\e[32mUsage: checkVCF.py ref-file vcf-file\e[32m";
	echo " "
        read -p """Enter the reference sequence first, then the vcf file separated by a space
                   (Please provide the absolute path to the files if you are not currently in the containing directory) 
                   Enter the basename of your vcf file e.g. camgwas-cr1.vcf.gz; basename = camgwas-chr
: """
        ref="$1"
        vcfbase="$2"
        for i in $(seq 1 22);
        do
		samtools faidx "${ref}"
                echo "`checkVCF.py -r "$ref" -o out "${vcfbase}""${i}".vcf.gz`"
        done
else
	echo -e "\n\e[30;1mUsage: checkVCF.py ref-file vcf-file\e[30;1m\n";
        echo " "
	read -p """Enter the reference sequence first, then the vcf file separated by a space
: """
        ref="$1"
        vcfbase="$2"
	echo "`checkVCF.py -r "$ref" -o out "${vcfbase}".vcf.gz`"
fi

