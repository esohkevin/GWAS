bcftools concat -a -d none -Oz ALL.chr{1..22}.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz -o Phase3_merged.vcf.gz

tabix -p vcf Phase3_merged.vcf.gz

bcftools view -k -m2 -M2 -p -Oz -v snps Phase3_merged.vcf.gz -o Phase3_1kgpsnps.vcf.gz	# -v: select snps only | -k: select known sites only (not '.')
											# -m -M: max # REF and max # ALT alleles (-m2 -M2 for biallelic only)
											# -p: sites for which all samples are phased
