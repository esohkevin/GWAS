#!/bin/bash

plink --bfile imputed_clean --logistic --ci 0.95 --adjust --out testbansemiban --covar phasedWrefImpute2.cov --covar-name C1-C10 --keep ../../samples/include_bantu-semibantu.txt

plink --bfile imputed_clean --logistic --ci 0.95 --adjust --out testban --covar phasedWrefImpute2.cov --covar-name C1-C10 --keep ../../samples/include_bantu.txt

plink --bfile imputed_clean --logistic --ci 0.95 --adjust --out testsemiban --covar phasedWrefImpute2.cov --covar-name C1-C10 --keep ../../samples/include_semibantu.txt

plink --bfile imputed_clean --logistic --ci 0.95 --adjust --out testsm --covar phasedWrefImpute2.cov --covar-name C1-C10 --keep ../../samples/smcon.ids

plink --bfile imputed_clean --logistic --ci 0.95 --adjust --out testsma --covar phasedWrefImpute2.cov --covar-name C1-C10 --keep ../../samples/smacon.ids

plink --bfile imputed_clean --logistic --ci 0.95 --adjust --out testcm --covar phasedWrefImpute2.cov --covar-name C1-C10 --keep ../../samples/cmcon.ids

plink --bfile imputed_clean --logistic --ci 0.95 --adjust --out testNofo --covar phasedWrefImpute2.cov --covar-name C1-C10 --remove ../../samples/exclude_fo.txt


