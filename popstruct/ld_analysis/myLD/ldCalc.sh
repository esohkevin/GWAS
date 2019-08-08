## File to calculate LD using VCFtools
## It calculates point estimates for the CP groups
## As well as bootstraps and then calculates LD
## Started 5 November 2015
## Christian Parobek


########################
###### PARAMETERS ######
########################



vcf2use="$1"
sample="$2"
#vcf2use=args[1]

########################
## CP POINT ESTIMATES ##
########################

for i in 11
do

## split vcf
#vcftools --gzvcf $vcf2use \
#	--recode \
#	--out chr$i

## calculate LD
vcftools --gzvcf $vcf2use \
	--hap-r2 \
	--keep $2 \
	--ld-window-bp 100000 \
	--out chr$i.ld.1-100000

done


########################
####### BOOTSTRAP ######
########################

for strap in {1..100} # number of bootstraps to do
do

	## sample without replacement
	## sampling with replacement is impossible with vcftools
	## pull 17 isolates
	shuf -n17 $sample >> bootstrap/boot/boot$strap.txt

	## subsample the VCF
	vcftools --gzvcf $vcf2use \
		--keep bootstrap/boot/boot$strap.txt \
		--recode \
		--out bootstrap/vcfs/boot$strap

	## calculate LD stats
	vcftools --gzvcf bootstrap/vcfs/boot$strap.recode.vcf \
		--hap-r2 \
		--ld-window-bp 100000 \
		--out bootstrap/ld/boot$strap.ld.1-100000

echo $strap
done

