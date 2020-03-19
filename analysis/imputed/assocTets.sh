#!/bin/bash

ind="~/Git/GWAS/phase/indall/"
sam="~/Git/GWAS/samples/"

plink --bfile ${ind}imputed_clean --logistic --ci 0.95 --adjust --out bansemiban --covar pop.pca.txt --covar-name C1-C2 --keep ${sam}include_bantu-semibantu.txt
plink --bfile ${ind}imputed_clean --logistic hethom hide-covar --ci 0.95 --adjust --out bansemibanhet --covar pop.pca.txt --covar-name C1-C2 --keep ${sam}include_bantu-semibantu.txt
plink --bfile ${ind}imputed_clean --logistic genotypic hide-covar --ci 0.95 --adjust --out bansemibangeno --covar pop.pca.txt --covar-name C1-C2 --keep ${sam}include_bantu-semibantu.txt
plink --bfile ${ind}imputed_clean --logistic dominant hide-covar --ci 0.95 --adjust --out bansemibandom --covar pop.pca.txt --covar-name C1-C2 --keep ${sam}include_bantu-semibantu.txt
plink --bfile ${ind}imputed_clean --logistic recessive hide-covar --ci 0.95 --adjust --out bansemibanrec --covar pop.pca.txt --covar-name C1-C2 --keep ${sam}include_bantu-semibantu.txt

plink --bfile ${ind}imputed_clean --logistic --ci 0.95 --adjust --out ba --covar pop.pca.txt --covar-name C1-C2 --keep ${sam}include_bantu.txt
plink --bfile ${ind}imputed_clean --logistic hethom hide-covar --ci 0.95 --adjust --out bahet --covar pop.pca.txt --covar-name C1-C2 --keep ${sam}include_bantu.txt
plink --bfile ${ind}imputed_clean --logistic genotypic hide-covar --ci 0.95 --adjust --out bageno --covar pop.pca.txt --covar-name C1-C2 --keep ${sam}include_bantu.txt
plink --bfile ${ind}imputed_clean --logistic dominant hide-covar --ci 0.95 --adjust --out badom --covar pop.pca.txt --covar-name C1-C2 --keep ${sam}include_bantu.txt
plink --bfile ${ind}imputed_clean --logistic recessive hide-covar --ci 0.95 --adjust --out barec --covar pop.pca.txt --covar-name C1-C2 --keep ${sam}include_bantu.txt

plink --bfile ${ind}imputed_clean --logistic --ci 0.95 --adjust --out sb --covar pop.pca.txt --covar-name C1-C2 --keep ${sam}include_semibantu.txt
plink --bfile ${ind}imputed_clean --logistic hethom hide-covar --ci 0.95 --adjust --out sbhet --covar pop.pca.txt --covar-name C1-C2 --keep ${sam}smcon.ids
plink --bfile ${ind}imputed_clean --logistic genotypic hide-covar --ci 0.95 --adjust --out sbgeno --covar pop.pca.txt --covar-name C1-C2 --keep ${sam}smcon.ids
plink --bfile ${ind}imputed_clean --logistic dominant hide-covar --ci 0.95 --adjust --out sbdom --covar pop.pca.txt --covar-name C1-C2 --keep ${sam}smcon.ids
plink --bfile ${ind}imputed_clean --logistic recessive hide-covar --ci 0.95 --adjust --out sbrec --covar pop.pca.txt --covar-name C1-C2 --keep ${sam}smcon.ids

plink --bfile ${ind}imputed_clean --logistic --ci 0.95 --adjust --out sm --covar pop.pca.txt --covar-name C1-C2 --keep ${sam}smcon.ids --remove ${sam}exclude_fo.txt
plink --bfile ${ind}imputed_clean --logistic hethom hide-covar --ci 0.95 --adjust --out smhet --covar pop.pca.txt --covar-name C1-C2 --keep ${sam}smcon.ids --remove ${sam}exclude_fo.txt
plink --bfile ${ind}imputed_clean --logistic genotypic hide-covar --ci 0.95 --adjust --out smgeno --covar pop.pca.txt --covar-name C1-C2 --keep ${sam}smcon.ids --remove ${sam}exclude_fo.txt
plink --bfile ${ind}imputed_clean --logistic dominant hide-covar --ci 0.95 --adjust --out smdom --covar pop.pca.txt --covar-name C1-C2 --keep ${sam}smcon.ids --remove ${sam}exclude_fo.txt
plink --bfile ${ind}imputed_clean --logistic recessive hide-covar --ci 0.95 --adjust --out smrec --covar pop.pca.txt --covar-name C1-C2 --keep ${sam}smcon.ids --remove ${sam}exclude_fo.txt

plink --bfile ${ind}imputed_clean --logistic --ci 0.95 --adjust --out sma --covar pop.pca.txt --covar-name C1-C2 --keep ${sam}smacon.ids --remove ${sam}exclude_fo.txt
plink --bfile ${ind}imputed_clean --logistic hethom hide-covar --ci 0.95 --adjust --out smahet --covar pop.pca.txt --covar-name C1-C2 --keep ${sam}smacon.ids --remove ${sam}exclude_fo.txt
plink --bfile ${ind}imputed_clean --logistic genotypic hide-covar --ci 0.95 --adjust --out smageno --covar pop.pca.txt --covar-name C1-C2 --keep ${sam}smacon.ids --remove ${sam}exclude_fo.txt
plink --bfile ${ind}imputed_clean --logistic dominant hide-covar --ci 0.95 --adjust --out smadom --covar pop.pca.txt --covar-name C1-C2 --keep ${sam}smacon.ids --remove ${sam}exclude_fo.txt
plink --bfile ${ind}imputed_clean --logistic recessive hide-covar --ci 0.95 --adjust --out smarec --covar pop.pca.txt --covar-name C1-C2 --keep ${sam}smacon.ids --remove ${sam}exclude_fo.txt

plink --bfile ${ind}imputed_clean --logistic --ci 0.95 --adjust --out cm --covar pop.pca.txt --covar-name C1-C2 --keep ${sam}cmcon.ids --remove ${sam}exclude_fo.txt
plink --bfile ${ind}imputed_clean --logistic hethom hide-covar --ci 0.95 --adjust --out cmhet --covar pop.pca.txt --covar-name C1-C2 --keep ${sam}cmcon.ids --remove ${sam}exclude_fo.txt
plink --bfile ${ind}imputed_clean --logistic genotypic hide-covar --ci 0.95 --adjust --out cmgeno --covar pop.pca.txt --covar-name C1-C2 --keep ${sam}cmcon.ids --remove ${sam}exclude_fo.txt
plink --bfile ${ind}imputed_clean --logistic dominant hide-covar --ci 0.95 --adjust --out cmdom --covar pop.pca.txt --covar-name C1-C2 --keep ${sam}cmcon.ids --remove ${sam}exclude_fo.txt
plink --bfile ${ind}imputed_clean --logistic recessive hide-covar --ci 0.95 --adjust --out cmrec --covar pop.pca.txt --covar-name C1-C2 --keep ${sam}cmcon.ids --remove ${sam}exclude_fo.txt
