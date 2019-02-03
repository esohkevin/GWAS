#!/bin/bash

for i in chr*.dose.vcf.gz; 
do
	bcftools filter --exclude 'INFO/R2<0.75' -Oz --output ${i/.dose.vcf.gz/.filtered.vcf.gz} ${i}
done
