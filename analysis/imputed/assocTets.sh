#!/bin/bash

plink --bfile imputed_clean --logistic --ci 0.95 --adjust --out testbansemiban --covar pop.pca.txt --covar-name C1-C2 --keep ../../samples/include_bantu-semibantu.txt

plink --bfile imputed_clean --logistic --ci 0.95 --adjust --out testban --covar pop.pca.txt --covar-name C1-C2 --keep ../../samples/include_bantu.txt

plink --bfile imputed_clean --logistic --ci 0.95 --adjust --out testsemiban --covar pop.pca.txt --covar-name C1-C2 --keep ../../samples/include_semibantu.txt

plink --bfile imputed_clean --logistic --ci 0.95 --adjust --out testsm --covar pop.pca.txt --covar-name C1-C2 --keep ../../samples/smcon.ids

plink --bfile imputed_clean --logistic --ci 0.95 --adjust --out testsma --covar pop.pca.txt --covar-name C1-C2 --keep ../../samples/smacon.ids

plink --bfile imputed_clean --logistic --ci 0.95 --adjust --out testcm --covar pop.pca.txt --covar-name C1-C2 --keep ../../samples/cmcon.ids

plink --bfile imputed_clean --logistic --ci 0.95 --adjust --out testNofo --covar pop.pca.txt --covar-name C1-C2 --remove ../../samples/exclude_fo.txt


