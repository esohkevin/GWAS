plink --bfile cam11 --exclude Exclude-cam11-1000G.txt --make-bed --out TEMP1
plink --bfile TEMP1 --update-map Chromosome-cam11-1000G.txt --update-chr --make-bed --out TEMP2
plink --bfile TEMP2 --update-map Position-cam11-1000G.txt --make-bed --out TEMP3
plink --bfile TEMP3 --flip Strand-Flip-cam11-1000G.txt --make-bed --out TEMP4
plink --bfile TEMP4 --reference-allele Force-Allele1-cam11-1000G.txt --make-bed --out cam11-updated
plink --bfile cam11-updated --reference-allele Force-Allele1-cam11-1000G.txt --make-bed --chr 1 --out cam11-updated-chr1
plink --bfile cam11-updated --reference-allele Force-Allele1-cam11-1000G.txt --make-bed --chr 2 --out cam11-updated-chr2
plink --bfile cam11-updated --reference-allele Force-Allele1-cam11-1000G.txt --make-bed --chr 3 --out cam11-updated-chr3
plink --bfile cam11-updated --reference-allele Force-Allele1-cam11-1000G.txt --make-bed --chr 4 --out cam11-updated-chr4
plink --bfile cam11-updated --reference-allele Force-Allele1-cam11-1000G.txt --make-bed --chr 5 --out cam11-updated-chr5
plink --bfile cam11-updated --reference-allele Force-Allele1-cam11-1000G.txt --make-bed --chr 6 --out cam11-updated-chr6
plink --bfile cam11-updated --reference-allele Force-Allele1-cam11-1000G.txt --make-bed --chr 7 --out cam11-updated-chr7
plink --bfile cam11-updated --reference-allele Force-Allele1-cam11-1000G.txt --make-bed --chr 8 --out cam11-updated-chr8
plink --bfile cam11-updated --reference-allele Force-Allele1-cam11-1000G.txt --make-bed --chr 9 --out cam11-updated-chr9
plink --bfile cam11-updated --reference-allele Force-Allele1-cam11-1000G.txt --make-bed --chr 10 --out cam11-updated-chr10
plink --bfile cam11-updated --reference-allele Force-Allele1-cam11-1000G.txt --make-bed --chr 11 --out cam11-updated-chr11
plink --bfile cam11-updated --reference-allele Force-Allele1-cam11-1000G.txt --make-bed --chr 12 --out cam11-updated-chr12
plink --bfile cam11-updated --reference-allele Force-Allele1-cam11-1000G.txt --make-bed --chr 13 --out cam11-updated-chr13
plink --bfile cam11-updated --reference-allele Force-Allele1-cam11-1000G.txt --make-bed --chr 14 --out cam11-updated-chr14
plink --bfile cam11-updated --reference-allele Force-Allele1-cam11-1000G.txt --make-bed --chr 15 --out cam11-updated-chr15
plink --bfile cam11-updated --reference-allele Force-Allele1-cam11-1000G.txt --make-bed --chr 16 --out cam11-updated-chr16
plink --bfile cam11-updated --reference-allele Force-Allele1-cam11-1000G.txt --make-bed --chr 17 --out cam11-updated-chr17
plink --bfile cam11-updated --reference-allele Force-Allele1-cam11-1000G.txt --make-bed --chr 18 --out cam11-updated-chr18
plink --bfile cam11-updated --reference-allele Force-Allele1-cam11-1000G.txt --make-bed --chr 19 --out cam11-updated-chr19
plink --bfile cam11-updated --reference-allele Force-Allele1-cam11-1000G.txt --make-bed --chr 20 --out cam11-updated-chr20
plink --bfile cam11-updated --reference-allele Force-Allele1-cam11-1000G.txt --make-bed --chr 21 --out cam11-updated-chr21
plink --bfile cam11-updated --reference-allele Force-Allele1-cam11-1000G.txt --make-bed --chr 22 --out cam11-updated-chr22
plink --bfile cam11-updated --reference-allele Force-Allele1-cam11-1000G.txt --make-bed --chr 23 --out cam11-updated-chr23
rm TEMP*
