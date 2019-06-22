plink --bfile raw --exclude at-cg.snps --make-bed --out TEMP0
plink --bfile TEMP0 --exclude Exclude-raw-1000G.txt --make-bed --out TEMP1
plink --bfile TEMP1 --update-chr Chromosome-raw-1000G.txt --make-bed --out TEMP2
plink --bfile TEMP2 --update-map Position-raw-1000G.txt --make-bed --out TEMP3
plink --bfile TEMP3 --flip Strand-Flip-raw-1000G.txt --make-bed --out TEMP4
plink --bfile TEMP4 --reference-allele Force-Allele1-raw-1000G.txt --make-bed --out raw-updated
rm TEMP*
