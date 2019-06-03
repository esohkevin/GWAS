#!/usr/bin/Rscript

mergeData <- read.table("adm-data.fam", col.names=c("FID","IID","C1","C2","SEX","PHE"), as.is=T)
mergePops <- read.table("../eig/world/CONVERTF/qc-world-eth.ind", col.names=c("FID","SEX","ETH"), as.is=T)
admPops <- merge(mergeData, mergePops, by="FID")
write.table(admPops, file="admPopsTemplate.txt", col.names=T, row.names=F, quote=F, sep="\t")
write.table(admPops[,8], file="adm-data.pop", col.names=F, row.names=F, quote=F, sep="\t")

