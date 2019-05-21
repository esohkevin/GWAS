plink --bfile qc-camgwas --allow-no-sex --exclude at-cg.snps --make-bed --out TEMP0
plink --bfile TEMP0 --exclude Exclude-qc-camgwas-1000G.txt --make-bed --out TEMP1
plink --bfile TEMP1 --update-map Chromosome-qc-camgwas-1000G.txt --update-chr --make-bed --out TEMP2
plink --bfile TEMP2 --update-map Position-qc-camgwas-1000G.txt --make-bed --out TEMP3
plink --bfile TEMP3 --flip Strand-Flip-qc-camgwas-1000G.txt --make-bed --out TEMP4
plink --bfile TEMP4 --reference-allele Force-Allele1-qc-camgwas-1000G.txt --make-bed --out qc-camgwas-updated
rm TEMP*
