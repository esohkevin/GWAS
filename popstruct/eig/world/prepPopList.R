#!/usr/bin/Rscript

famFile <- read.table("merged-data-pruned.fam", col.names=c("FID", "IID", "missing", "het", "sex", "pheno"), as.is=T)
ethFile <- read.table("merged-data-eth_template.txt", col.names=c("FID", "eth"), as.is=T)
popList <- merge(data.frame(FID=famFile[,1]), data.frame(ethFile[,1:2]), by="FID")
write.table(popList[,2], file="poplist.txt", col.names=T, row.names=F, quote=F)

