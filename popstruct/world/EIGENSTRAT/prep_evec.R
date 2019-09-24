#!/usr/bin/Rscript


### Africa
evecDat <- read.table("afr.pca.evec", col.names=c("Sample","PC1","PC2","PC3","PC4","PC5","PC6","PC7","PC8","PC9","PC10","Status"), as.is=T)

popGrps <- read.table("africaGrops.txt", col.names=c("Sample","Pop","PopGroup"), as.is=T)

pcaDat <- merge(evecDat, popGrps, by="Sample")

write.table(pcaDat, file="afr.pca.txt", col.names=T, row.names=F, quote=F, sep="\t")

### World
evecDat <- read.table("world.pca.evec", col.names=c("Sample","PC1","PC2","PC3","PC4","PC5","PC6","PC7","PC8","PC9","PC10","Status"), as.is=T)

popGrps <- read.table("world-popGrp.txt", col.names=c("Sample","Pop","PopGroup"), as.is=T)

pcaDat <- merge(evecDat, popGrps, by="Sample")

write.table(pcaDat, file="world-evecDat.txt", col.names=T, row.names=F, quote=F, sep="\t")

