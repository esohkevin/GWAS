#!/usr/bin/env bash
plink --bfile test --make-grm-bin --out test --keep-allele-order
gcta64 --bfile test --mlma --pheno test.phen --grm test --out test --thread-num 24
