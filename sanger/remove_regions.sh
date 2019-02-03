#!/bin/bash

remove_sites() {
for i in "$@"; do
	if [[ "$1" == "0" ]];
	then
		cp "${2}" ${2}.bak
		bcftools view -t ^X:154931044-155270560,X:154931044-155270560,X:154931044-155270560,X:154931044-155270560,X:154931044-155270560,X:154931044-155270560,X:154931044-155270560,X:154931044-155270560,X:154931044-155270560,X:154931044-155270560,X:154931044-155270560,X:154931044-155270560,X:154931044-155270560,X:154931044-155270560,X:154931044-155270560 "$2" -o "${2/.vcf*/.vcf}"
		bgzip -f "${2/.vcf*/.vcf}"
		tabix -p vcf "${2/.vcf*/.vcf.gz}"
#		mv qc-camgwas-updated-2.vcf.gz qc-camgwas-updated.vcf.gz
#		mv qc-camgwas-updated-2.vcf.gz.tbi qc-camgwas-updated.vcf.gz.tbi
	elif [[ "$1" == "1" ]];
	then
		bcftools view -t ^X:154931044-155270560,X:154931044-155270560,X:154931044-155270560,X:154931044-155270560,X:154931044-155270560,X:154931044-155270560,X:154931044-155270560,X:154931044-155270560,X:154931044-155270560,X:154931044-155270560,X:154931044-155270560,X:154931044-155270560,X:154931044-155270560,X:154931044-155270560,X:154931044-155270560 "$2" -o "${2/.vcf*/.vcf}"
        	bgzip -f "${2/.vcf*/.vcf}"
        	tabix -p vcf "${2/.vcf*/.vcf.gz}"
	else
		echo "Please select "0" for Sanger or "1" for Michigan"
	fi
done
}
