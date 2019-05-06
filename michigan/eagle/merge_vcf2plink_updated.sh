################# Post Imputation GWAS Analysis ###################

# Chech duplicate positions (snps) to exclude from downstream analyses
#zgrep -v "^#" merge.filtered.vcf.gz | cut -f3 | sort | uniq -d > merge.filtered.dups

# Covert autosomal imputed and filtered genotypes to plink binary format 
plink \
	--vcf merge.filtered.vcf.gz \
	--exclude merge.filtered.dups \
        --allow-no-sex \
        --make-bed \
	--vcf-min-gp 0.90 \
        --biallelic-only \
	--keep-allele-order \
	--double-id \
        --out merge.filtered

# Update the dataset with casecontrol status from sample files
plink \
	--bfile merge.filtered \
	--allow-no-sex \
	--pheno update-camgwas.phe \
	--1 \
	--update-name update-ucsc.ids 2 1 \
	--update-sex update-camgwas.sex \
	--maf 0.01 \
	--geno 0.1 \
	--hwe 1e-6 \
	--make-bed \
	--out merge.filtered-updated



