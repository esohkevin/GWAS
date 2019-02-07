################# Post Imputation GWAS Analysis ###################

# Chech duplicate positions (snps) to exclude from downstream analyses
zgrep -v "^#" merge.filtered.vcf.gz | cut -f3 | sort | uniq -d > merge.filtered.dups
zgrep -v "^#" chrX.auto.filtered.vcf.gz | cut -f3 | sort | uniq -d > chrX.auto.filtered.dups
zgrep -v "^#" chrX.no.auto_female.filtered.vcf.gz | cut -f3 | sort | uniq -d > chrX.no.auto_female.filtered.dups

# Covert autosomal imputed and filtered genotypes to plink binary format 
plink \
	--vcf merge.filtered.vcf.gz \
	--exclude merge.filtered.dups \
        --allow-no-sex \
        --make-bed \
	--vcf-min-gp 0.9 \
        --biallelic-only \
        --out merge.filtered

# Convert non-autosomal imputed and filtered genotypes to plink binary format
plink \
        --vcf chrX.auto.filtered.vcf.gz \
        --allow-no-sex \
	--exclude chrX.auto.filtered.dups \
        --make-bed \
	--vcf-min-gp 0.9 \
        --biallelic-only \
        --out chrX.auto.filtered

plink \
	--vcf chrX.no.auto_female.filtered.vcf.gz \
	--allow-no-sex \
	--exclude chrX.no.auto_female.filtered.dups \
	--make-bed \
	--vcf-min-gp 0.9 \
	--biallelic-only \
	--out chrX.no.auto_female.filtered
