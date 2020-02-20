#!/usr/bin/env Rscript

f <- read.table("../world/pca_eth_world_pops.txt",h=T)
s <- read.table("world.ind", col.names=c("Sample","Sex","Pop"))
fs <- merge(s,f,by="Sample")
fs_ind <- fs[,c(1,4:5)]
write.table(fs_ind, "world-ald.ind",col.names=F, row.names=F,quote=F,sep=" ")

