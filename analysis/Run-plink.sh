plink --bfile qc-camgwas-eig-corr --exclude Exclude-qc-camgwas-eig-corr-1000G.txt --make-bed --out TEMP1
plink --bfile TEMP1 --update-map Chromosome-qc-camgwas-eig-corr-1000G.txt --update-chr --make-bed --out TEMP2
plink --bfile TEMP2 --update-map Position-qc-camgwas-eig-corr-1000G.txt --make-bed --out TEMP3
plink --bfile TEMP3 --flip Strand-Flip-qc-camgwas-eig-corr-1000G.txt --make-bed --out TEMP4
plink --bfile TEMP4 --reference-allele Force-Allele1-qc-camgwas-eig-corr-1000G.txt --make-bed --out qc-camgwas-eig-corr-updated
plink --bfile qc-camgwas-eig-corr-updated --reference-allele Force-Allele1-qc-camgwas-eig-corr-1000G.txt --make-bed --chr 1 --out qc-camgwas-eig-corr-updated-chr1
plink --bfile qc-camgwas-eig-corr-updated --reference-allele Force-Allele1-qc-camgwas-eig-corr-1000G.txt --make-bed --chr 2 --out qc-camgwas-eig-corr-updated-chr2
plink --bfile qc-camgwas-eig-corr-updated --reference-allele Force-Allele1-qc-camgwas-eig-corr-1000G.txt --make-bed --chr 3 --out qc-camgwas-eig-corr-updated-chr3
plink --bfile qc-camgwas-eig-corr-updated --reference-allele Force-Allele1-qc-camgwas-eig-corr-1000G.txt --make-bed --chr 4 --out qc-camgwas-eig-corr-updated-chr4
plink --bfile qc-camgwas-eig-corr-updated --reference-allele Force-Allele1-qc-camgwas-eig-corr-1000G.txt --make-bed --chr 5 --out qc-camgwas-eig-corr-updated-chr5
plink --bfile qc-camgwas-eig-corr-updated --reference-allele Force-Allele1-qc-camgwas-eig-corr-1000G.txt --make-bed --chr 6 --out qc-camgwas-eig-corr-updated-chr6
plink --bfile qc-camgwas-eig-corr-updated --reference-allele Force-Allele1-qc-camgwas-eig-corr-1000G.txt --make-bed --chr 7 --out qc-camgwas-eig-corr-updated-chr7
plink --bfile qc-camgwas-eig-corr-updated --reference-allele Force-Allele1-qc-camgwas-eig-corr-1000G.txt --make-bed --chr 8 --out qc-camgwas-eig-corr-updated-chr8
plink --bfile qc-camgwas-eig-corr-updated --reference-allele Force-Allele1-qc-camgwas-eig-corr-1000G.txt --make-bed --chr 9 --out qc-camgwas-eig-corr-updated-chr9
plink --bfile qc-camgwas-eig-corr-updated --reference-allele Force-Allele1-qc-camgwas-eig-corr-1000G.txt --make-bed --chr 10 --out qc-camgwas-eig-corr-updated-chr10
plink --bfile qc-camgwas-eig-corr-updated --reference-allele Force-Allele1-qc-camgwas-eig-corr-1000G.txt --make-bed --chr 11 --out qc-camgwas-eig-corr-updated-chr11
plink --bfile qc-camgwas-eig-corr-updated --reference-allele Force-Allele1-qc-camgwas-eig-corr-1000G.txt --make-bed --chr 12 --out qc-camgwas-eig-corr-updated-chr12
plink --bfile qc-camgwas-eig-corr-updated --reference-allele Force-Allele1-qc-camgwas-eig-corr-1000G.txt --make-bed --chr 13 --out qc-camgwas-eig-corr-updated-chr13
plink --bfile qc-camgwas-eig-corr-updated --reference-allele Force-Allele1-qc-camgwas-eig-corr-1000G.txt --make-bed --chr 14 --out qc-camgwas-eig-corr-updated-chr14
plink --bfile qc-camgwas-eig-corr-updated --reference-allele Force-Allele1-qc-camgwas-eig-corr-1000G.txt --make-bed --chr 15 --out qc-camgwas-eig-corr-updated-chr15
plink --bfile qc-camgwas-eig-corr-updated --reference-allele Force-Allele1-qc-camgwas-eig-corr-1000G.txt --make-bed --chr 16 --out qc-camgwas-eig-corr-updated-chr16
plink --bfile qc-camgwas-eig-corr-updated --reference-allele Force-Allele1-qc-camgwas-eig-corr-1000G.txt --make-bed --chr 17 --out qc-camgwas-eig-corr-updated-chr17
plink --bfile qc-camgwas-eig-corr-updated --reference-allele Force-Allele1-qc-camgwas-eig-corr-1000G.txt --make-bed --chr 18 --out qc-camgwas-eig-corr-updated-chr18
plink --bfile qc-camgwas-eig-corr-updated --reference-allele Force-Allele1-qc-camgwas-eig-corr-1000G.txt --make-bed --chr 19 --out qc-camgwas-eig-corr-updated-chr19
plink --bfile qc-camgwas-eig-corr-updated --reference-allele Force-Allele1-qc-camgwas-eig-corr-1000G.txt --make-bed --chr 20 --out qc-camgwas-eig-corr-updated-chr20
plink --bfile qc-camgwas-eig-corr-updated --reference-allele Force-Allele1-qc-camgwas-eig-corr-1000G.txt --make-bed --chr 21 --out qc-camgwas-eig-corr-updated-chr21
plink --bfile qc-camgwas-eig-corr-updated --reference-allele Force-Allele1-qc-camgwas-eig-corr-1000G.txt --make-bed --chr 22 --out qc-camgwas-eig-corr-updated-chr22
plink --bfile qc-camgwas-eig-corr-updated --reference-allele Force-Allele1-qc-camgwas-eig-corr-1000G.txt --make-bed --chr 23 --out qc-camgwas-eig-corr-updated-chr23
rm TEMP*
