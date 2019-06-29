plink --bfile cam11 --exclude at-cg.snps --make-bed --out TEMP0
plink --bfile TEMP0 --exclude Exclude-cam11-1000G.txt --make-bed --out TEMP1
plink --bfile TEMP1 --update-chr Chromosome-cam11-1000G.txt --make-bed --out TEMP2
plink --bfile TEMP2 --update-map Position-cam11-1000G.txt --make-bed --out TEMP3
plink --bfile TEMP3 --flip Strand-Flip-cam11-1000G.txt --make-bed --out TEMP4
plink --bfile TEMP4 --reference-allele Force-Allele1-cam11-1000G.txt --make-bed --out cam11-updated
rm TEMP*
