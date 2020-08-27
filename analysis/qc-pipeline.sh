###### CAMEROON GWAS DATA ANALYSIS PIPELINE ######
# Data: 
#	Genotype:	camgwas_merge.vcf.gz
#			raw-camgwas.gen 
#
#			from: 

#runplink() {
images="../images/"
samples="../samples/"
mkdir -p ../images
king="${HOME}/bin/king"
#read -p 'Please provide your genotype vcf file: ' vcf

# #--------
# plink \
# 	--vcf ../../../git/data/CamGWASMerged.vcf.gz \
# 	--recode oxford \
# 	--remove ${samples}missingEthnicity.ids \
# 	--allow-no-sex \
# 	--double-id \
# 	--out raw-camgwas
# cp ${samples}raw-camgwas.sample .
# 
# 
# #-------- Check for duplicate SNPs
# plink \
# 	--data raw-camgwas \
# 	--allow-no-sex \
# 	--list-duplicate-vars ids-only suppress-first \
# 	--out dups

# #-------- Make plink binary files from Oxford .gen + .sample files spliting chrX 
# #-------- by the PARs using the b37 coordinates while removing duplicate SNPs
# plink \
# 	--data raw-camgwas \
# 	--make-bed \
# 	--exclude dups.dupvar \
# 	--split-x b37 \
# 	--allow-no-sex \
# 	--out raw-camGwas
# 
# #-------- Update SNPID names with rsids
# cut -f2 raw-camGwas.bim > all.snps.ids
# cut -f1 -d',' all.snps.ids > all.rs.ids
# paste all.rs.ids all.snps.ids > allMysnps.txt
# 
# plink \
#         --bfile raw-camGwas \
#         --update-name allMysnps.txt 1 2 \
#         --allow-no-sex \
#         --make-bed \
#         --out raw-camgwas
# 
#-------- LD-prune the raw data before sex check
plink \
        --bfile raw-camgwas \
        --allow-no-sex \
        --indep-pairwise 50 10 0.2 \
	--set-hh-missing \
        --out prunedsnplist

#-------- Now extract the pruned SNPs to perform check-sex on
plink \
        --bfile raw-camgwas \
        --allow-no-sex \
        --extract prunedsnplist.prune.in \
        --make-bed \
        --out check-sex-data

#-------- Check for sex concordance
plink \
	--bfile check-sex-data \
	--check-sex \
	--set-hh-missing \
	--allow-no-sex \
	--out check-sex-data

#-------- Extract FIDs and IIDs of individuals flagged with error 
#-------- (PROBLEM) in the .sexcheck file (failed sex check)
grep "PROBLEM" check-sex-data.sexcheck | awk '{print $1"\t"$2}' > fail-checksex.qc

#-------- Compute missing data stats
plink \
	--bfile raw-camgwas \
	--missing \
	--allow-no-sex \
	--set-hh-missing \
	--out raw-camgwas

#-------- Compute heterozygosity stats
plink \
	--bfile raw-camgwas \
	--het \
	--allow-no-sex \
	--set-hh-missing \
	--out raw-camgwas

echo -e """\e[38;5;40m
	##########################################################################
	##	    Perform per individual missing rate QC in R			##
	##########################################################################
	\e[0m
	"""
echo -e "\n\e[38;5;40mNow generating plots for per individual missingness in R. Please wait...\e[0m"

Rscript indmissing.R raw-camgwas.het raw-camgwas.imiss

#-------- Extract a subset of frequent individuals to produce an IBD 
#-------- report to check duplicate or related individuals baseDird on autosomes
plink2 \
	--bfile raw-camgwas \
	--autosome \
	--maf 0.30 \
	--geno 0.02 \
	--hwe 1e-6 keep-fewhet \
	--allow-no-sex \
	--make-bed \
	--out frequent


      $king \
      	-b frequent.bed \
      	--ibdseg \
      	--rplot \
      	--prefix frequent
      Rscript frequent_ibd1vsibd2.R frequent.segments.gz ibdseg
       awk '$10!="3rd" && $10!="4th" && $10!="UN"' frequent.seg | cut -f1 | sort | uniq | awk '{print $1"\t"$1}' > unrelated.ids

# #-------- Prune the list of frequent SNPs to remove those that fall within 
# #-------- 50bp with r^2 > 0.2 using a window size of 5bp
# plink \
# 	--bfile frequent \
# 	--allow-no-sex \
# 	--indep-pairwise 50 10 0.2 \
# 	--out prunedsnplist
# 
# #-------- Now generate the IBD report with the set of pruned SNPs 
# #-------- (prunedsnplist.prune.in - IN because they're the ones we're interested in)
# plink \
# 	--bfile frequent \
# 	--allow-no-sex \
# 	--extract prunedsnplist.prune.in \
# 	--genome \
# 	--out caseconpruned
# 
# echo -e """\e[38;5;40m
# 	#########################################################################
# 	#              Perform IBD analysis (relatedness) in R                  #
# 	#########################################################################
# 	\e[0m
# 	"""
# echo -e "\n\e[38;5;40mNow generating plots for IBD analysis in R. Please wait...\e[0m"

# Rscript ibdana.R

#------- Merge IDs of all individuals that failed per individual qc
#cat fail-checksex.qc  fail-het.qc  fail-mis.qc duplicate.ids1 | sort | uniq > fail-ind.qc
cat fail-checksex.qc  fail-het.qc  fail-mis.qc unrelated.ids | sort | uniq > fail-ind.qc

#-------- Remove individuals who failed per individual QC
plink \
	--bfile raw-camgwas \
	--make-bed \
	--allow-no-sex \
	--set-hh-missing \
	--remove fail-ind.qc \
	--out ind-qc-camgwas

#-------- Per SNP QC
#-------- Compute missing data rate for ind-qc-camgwas data
plink \
	--bfile ind-qc-camgwas \
	--allow-no-sex \
	--set-hh-missing \
	--missing \
	--out ind-qc-camgwas

# Compute MAF
plink \
	--bfile ind-qc-camgwas \
	--allow-no-sex \
	--set-hh-missing \
	--freq \
	--out ind-qc-camgwas

#-------- Compute differential missing genotype call rates (in cases and controls)
plink \
	--bfile ind-qc-camgwas \
	--allow-no-sex \
	--set-hh-missing \
	--test-missing \
	--out ind-qc-camgwas

echo -e """\e[38;5;40m
	#########################################################################
	#                        Perform per SNP QC in R                        #
	#########################################################################
	\e[0m
	"""
echo -e "\n\e[38;5;40mNow generating plots for per SNP QC in R. Please wait...\e[0m"

Rscript snpmissing.R ind-qc-camgwas.lmiss ind-qc-camgwas.frq ind-qc-camgwas.missing

#-------- Remove SNPs that failed per marker QC
plink2 \
	--bfile ind-qc-camgwas \
	--exclude fail-diffmiss.qc \
	--allow-no-sex \
	--maf 0.0001 \
	--hwe 1e-50 keep-fewhet \
	--geno 0.05 \
	--make-bed \
	--merge-x \
	--out qc-camgwas

echo -e """\e[38;5;40m
	#########################################################################
	#                          ChrX Quality Control                         #
	#########################################################################
	\e[0m
	"""
echo -e "\n\e[38;5;40mNow generating plots for per SNP QC in R. Please wait...\e[0m"

#------- Extract only autosomes for subsequently merging with QCed chrX
plink \
        --bfile qc-camgwas \
        --allow-no-sex \
        --make-bed \
        --autosome \
        --out qc-camgwas

plink \
	--bfile qc-camgwas \
	--allow-no-sex \
        --set-hh-missing \
	--make-bed \
	--autosome \
	--out qc-camgwas-autosome

##############################################################################
#                          UPDATE AUTOSOME IDs                               #
#                                                                            #

#cut -f1,4 qc-camgwas-autosome.bim | sed 's/\t/:/g' > qc-autosome.pos

#rm ucsc.ids
#for pos in `cat qc-autosome.pos`; do 
#	grep "${pos}" ucsc-rsids.txt | cut -f1 >> ucsc.ids 
#done
#cut -f2 qc-camgwas-autosome.bim > qc-autosome.ids

#paste ucsc.ids qc-autosome.ids > update_rsids.txt

#plink \
#        --bfile qc-camgwas \
#        --allow-no-sex \
#        --make-bed \
#	--autosome \
#	--update-name update_rsids.txt \
#	--out qc-camgwas-autosome					     #
#									     #
##############################################################################

#-------- Extract only chrX for QC
plink \
	--bfile qc-camgwas \
	--allow-no-sex \
        --set-hh-missing \
	--make-bed \
	--chr 23 \
	--out qc-camgwas-chrX

#-------- Compute differential missingness
plink \
        --bfile qc-camgwas-chrX \
        --allow-no-sex \
        --set-hh-missing \
        --test-missing \
        --out qc-camgwas-chrX

echo -e """\e[38;5;40m
	#########################################################################
	#                          chrX per SNP QC in R                         #
	#########################################################################
	\e[0m
	"""
echo -e "\n\e[38;5;40mPerforming ChrX per SNP QC in R. Please wait...\e[0m"

#Rscript xsnpmissing.R
awk '$5<1e-8' qc-camgwas-chrX.missing > fail-Xdiffmiss.qc

#-------- Now remove SNPs that failed chrX QC
plink2 \
        --bfile qc-camgwas-chrX \
        --exclude fail-Xdiffmiss.qc \
        --allow-no-sex \
        --maf 0.0001 \
        --hwe 1e-50 keep-fewhet \
        --geno 0.05 \
        --make-bed \
        --max-alleles 2 \
	--out qc-camgwas-chr23 

#-------- Merge autosome and chrX data sets again
plink \
	--bfile qc-camgwas-chr23 \
	--make-bed \
	--set-hh-missing \
	--out qc-camgwas-chr23

plink \
	--bfile qc-camgwas-autosome \
	--allow-no-sex \
	--bmerge qc-camgwas-chr23 \
	--set-hh-missing \
	--out qc-camgwas
#done
rm *~

echo -e """\e[38;5;40m
	#########################################################################
	#                     	   Updating QC rsids                            #
	#########################################################################
	\e[0m
	"""
cut -f1,4 qc-camgwas.bim | \
	sed 's/\t/:/g' > qc-camgwas.pos
cut -f2 qc-camgwas.bim > qc-camgwas.ids
paste qc-camgwas.ids qc-camgwas.pos > qc-camgwas-ids-pos.txt

plink \
	--bfile qc-camgwas \
	--update-name qc-camgwas-ids-pos.txt 2 1 \
	--allow-no-sex \
	--make-bed \
	--set-hh-missing \
	--exclude-snp kgp21103953 \
	--out qc-camgwas

plink \
	--bfile qc-camgwas \
	--update-name ../../../db/updateName.txt 1 2 \
	--allow-no-sex \
	--make-bed \
	--set-hh-missing \
	--out qc-camgwas

echo -e """\e[38;5;40m
	#########################################################################
	#                     Run Imputation Prep Script                        #
	#########################################################################
	\e[0m
	"""

# rm raw-camGwas.* *~ raw-camgwas.gen
# mv check-sex-data.sexcheck sexcheck.txt
# #rm raw-camgwas.* 
# rm qc-camgwas-autosome.* qc-camgwas-chr* 
# rm check-sex-data* qc-camgwas-ids-pos.txt qc-camgwas.pos
# rm *.hh qc-camgwas.ids
# rm frequent.* ind-qc-camgwas*
# rm caseconpruned.*
# rm pruned* dups*
# rm allMysnps.txt
# rm all.rs.ids all.snps.ids
# 
# mv *.png ${images}
# 
# # Perform Population Structure
# #cd ../popstruct/
# #./popstruct.sh
# #cd -
# #
# ##./imputePrep.sh
# #
# ##}
