plink --bfile raw --exclude Exclude-raw-1000G.txt --make-bed --out TEMP1
plink --bfile TEMP1 --update-map Chromosome-raw-1000G.txt --update-chr --make-bed --out TEMP2
plink --bfile TEMP2 --update-map Position-raw-1000G.txt --make-bed --out TEMP3
plink --bfile TEMP3 --flip Strand-Flip-raw-1000G.txt --make-bed --out TEMP4
plink --bfile TEMP4 --reference-allele Force-Allele1-raw-1000G.txt --make-bed --out raw-updated
plink --bfile raw-updated --reference-allele Force-Allele1-raw-1000G.txt --make-bed --chr 1 --out raw-updated-chr1
plink --bfile raw-updated --reference-allele Force-Allele1-raw-1000G.txt --make-bed --chr 2 --out raw-updated-chr2
plink --bfile raw-updated --reference-allele Force-Allele1-raw-1000G.txt --make-bed --chr 3 --out raw-updated-chr3
plink --bfile raw-updated --reference-allele Force-Allele1-raw-1000G.txt --make-bed --chr 4 --out raw-updated-chr4
plink --bfile raw-updated --reference-allele Force-Allele1-raw-1000G.txt --make-bed --chr 5 --out raw-updated-chr5
plink --bfile raw-updated --reference-allele Force-Allele1-raw-1000G.txt --make-bed --chr 6 --out raw-updated-chr6
plink --bfile raw-updated --reference-allele Force-Allele1-raw-1000G.txt --make-bed --chr 7 --out raw-updated-chr7
plink --bfile raw-updated --reference-allele Force-Allele1-raw-1000G.txt --make-bed --chr 8 --out raw-updated-chr8
plink --bfile raw-updated --reference-allele Force-Allele1-raw-1000G.txt --make-bed --chr 9 --out raw-updated-chr9
plink --bfile raw-updated --reference-allele Force-Allele1-raw-1000G.txt --make-bed --chr 10 --out raw-updated-chr10
plink --bfile raw-updated --reference-allele Force-Allele1-raw-1000G.txt --make-bed --chr 11 --out raw-updated-chr11
plink --bfile raw-updated --reference-allele Force-Allele1-raw-1000G.txt --make-bed --chr 12 --out raw-updated-chr12
plink --bfile raw-updated --reference-allele Force-Allele1-raw-1000G.txt --make-bed --chr 13 --out raw-updated-chr13
plink --bfile raw-updated --reference-allele Force-Allele1-raw-1000G.txt --make-bed --chr 14 --out raw-updated-chr14
plink --bfile raw-updated --reference-allele Force-Allele1-raw-1000G.txt --make-bed --chr 15 --out raw-updated-chr15
plink --bfile raw-updated --reference-allele Force-Allele1-raw-1000G.txt --make-bed --chr 16 --out raw-updated-chr16
plink --bfile raw-updated --reference-allele Force-Allele1-raw-1000G.txt --make-bed --chr 17 --out raw-updated-chr17
plink --bfile raw-updated --reference-allele Force-Allele1-raw-1000G.txt --make-bed --chr 18 --out raw-updated-chr18
plink --bfile raw-updated --reference-allele Force-Allele1-raw-1000G.txt --make-bed --chr 19 --out raw-updated-chr19
plink --bfile raw-updated --reference-allele Force-Allele1-raw-1000G.txt --make-bed --chr 20 --out raw-updated-chr20
plink --bfile raw-updated --reference-allele Force-Allele1-raw-1000G.txt --make-bed --chr 21 --out raw-updated-chr21
plink --bfile raw-updated --reference-allele Force-Allele1-raw-1000G.txt --make-bed --chr 22 --out raw-updated-chr22
plink --bfile raw-updated --reference-allele Force-Allele1-raw-1000G.txt --make-bed --chr 23 --out raw-updated-chr23
rm TEMP*
