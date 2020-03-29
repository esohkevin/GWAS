#!/usr/bin/Rscript
if (!require(data.table))
  install.packages("data.table", repos = "https://ftp.acc.umu.se/mirror/CRAN/")
if (!require(R.utils))
  install.packages("R.utils", repos = "https://ftp.acc.umu.se/mirror/CRAN/")
require(R.utils)
require(data.table)
args <- commandArgs(TRUE)
a <- args[1]
b <- args[2]
a <- "femi.fam"
b <- "updateName.txt"
fam <- fread(a, data.table = F, nThread = 10)
colnames(fam) <- c("chr","id","cm","pos","a","b")
rs <- fread(b, data.table = F, nThread = 10)
colnames(rs) <- c("id","key")
vcf_a <- fam[,c(1:3)]
vcf_a <- paste0(vcf_a,":",vcf_a)
res <- merge(vcf_a,rs, by = "key")
str(res)
