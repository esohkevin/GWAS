#!/usr/bin/Rscript

wld <- read.table("igsr_pops.txt", header=T, as.is=T)
cam_all <- read.table("qc-camgwas1185.eth", header=T, as.is=T)

all <- rbind(wld,cam)
all_sorted <- all[order(all[,4], all[,3]),]

write.table(all_sorted, file = "eth_world_pops.txt", col.names=T, row.names=F, quote=F, sep="\t")
