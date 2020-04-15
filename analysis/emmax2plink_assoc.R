#!/usr/bin/env Rscript

args <- commandArgs(TRUE)

if (length(args) < 2) {
   print("",quote=F)
   print("Usage: emmax2plink_assoc.R [emmax_assoc_file <file.ps>] [bim_file]",quote=F)
   print("",quote=F)
   quit(save="no")
} else {
       if(!require(data.table)) {
	  install.packages(data.table, repo="https://cloud.r-project.org")
       }
       f <- args[1]
       b <- args[2]
       o <- gsub(".ps",".assoc.ps",f)
       emm <- fread(f, data.table=F, nThread=10, h=T)
       bim <- fread(b,h=F, data.table=F, nThread=10)
       bim <- fread(b,h=F, data.table=F, nThread=10, col.names=c("CHR","SNP","cM","BP","A1","A2"))
       bp <- bim[,c(1:2,4)]
       merged <- merge(bp,emm,by="SNP")
       fwrite(merged, file=o, col.names=T, row.names=F, buffMB=10, nThread=10, sep=" ")
}
