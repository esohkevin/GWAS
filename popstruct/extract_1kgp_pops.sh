#!/bin/bash

# Extract population from each into separate files

#for file in include_*; do
#plink \
#	--vcf ../1000G/Phase3_merged.vcf.gz \
#	--keep $file \
#	--autosome \
#	--extract qc-rs.ids \
#	--allow-no-sex \
#	--make-bed \
#	--exclude-snp rs16959560 \
#	--biallelic-only \
#	--out 1kGp3_$file

#done

# Extract frequent, independent, biallelic SNPs from the 1KGP3 for population strcuture analysis
#plink \
#	--vcf ../1000G/Phase3_merged.vcf.gz \
#	--allow-no-sex \
#	--autosome \
#	--make-bed \
#	--biallelic-only \
#	--double-id \
#	--exclude-snp rs16959560 \
#	--geno 0.01 \
#	--indep-pairwise 50 5 0.2 \
#	--maf 0.35 \
#	--mind 0.1 \
#	--out 1kgp3_ps-data
	

# Split qc-camgwas data by region (Buea, Y'de and D'la)
#for file in *_sample.ids; do
#plink \
#	--bfile ../analysis/qc-camgwas-updated-autosome \
#	--keep $file \
#	--allow-no-sex \
#	--make-bed \
#	--out ${file/.ids/s};

#done

plink \
	--bfile ../analysis/qc-camgwas-updated \
	--thin-indiv-count 200 \
	--maked-bed \
	--autosome \
	--out qc-camgwas200

cut -f2 qc-camgwas200.bim > camgwas200.ids


pop="YRI ESN LWK GWD MSL"

for eachPop in $pop; do 
	cut -f1,4 igsr_phase3.samples | \
		grep $eachPop | cut -f1 > "$eachPop"1.ids
	cut -f1,4 igsr_phase3.samples | \
                grep $eachPop | cut -f1 > "$eachPop"2.ids
	paste "$eachPop"1.ids "$eachPop"2.ids > all_"$eachPop".ids
	rm "$eachPop"1.ids "$eachPop"2.ids
	plink \
		--vcf ../1000G/Phase3_merged.vcf.gz \
		--allow-no-sex \
		--autosome \
       		--make-bed \
		--extract camgwas200.ids \
		--keep all_$eachPop.ids \
       		--biallelic-only \
       		--exclude-snp rs16959560 \
       		--geno 0.04 \
       		--mind 0.1 \
       		--out 1kgp3_$eachPop

	plink \
		--bfile 1kgp3_$eachPop \
		--allow-no-sex \
		--freq \
		--out 1kgp3_$eachPop

#Rscript --vanilla 1kgp_snpmiss.R 1kgp3_$eachPop.frq ${eachPop}_maf.png		# Include SNP missing genotype test and uncomment this line
Rscript --vanilla 1kgp_maf.R 1kgp3_$eachPop.frq ${eachPop}_maf.png

done
