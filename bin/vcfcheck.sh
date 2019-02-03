#!/usr/bin/env bash

vcfcheck() {
for i in "$@"; do
	ref="$2"
	vcfbase="$3"
	if [[ "$1" == "0" ]];
	then

		for i in $(seq 1 23);
        	do
                	echo "`tabix -p vcf "${vcfbase}""${i}".vcf.gz`"
                	echo "`bcftools sort "${vcfbase}""${i}".vcf.gz -Oz -o "${vcfbase}""${i}".vcf.gz`"
        	done

        	for i in $(seq 1 23);
        	do
        	        echo "`checkVCF.py -r "$ref" -o out "${vcfbase}""${i}".vcf.gz`"
        	done
	elif [[ "$1" == "1" ]];
	then
		echo "`tabix -p vcf "${vcfbase}".vcf.gz`"
		echo "`bcftools sort "${vcfbase}".vcf.gz -Oz -o "${vcfbase}".vcf.gz`"
		echo "`checkVCF.py -r "$ref" -o out "${vcfbase}".vcf.gz`"
#		echo "`bcftools index "${vcfbase}".vcf.gz`"
	fi
done
}
