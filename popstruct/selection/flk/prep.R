#!/usr/bin/Rscript

require(data.table)

args <- commandArgs(TRUE)

fn <- args[1]
pr <- args[2]
pe <- paste0(args[2], ".ped")
ma <- paste0(args[2], ".map")
outpe <- paste0(args[2], "flk.ped")
outma <- paste0(args[2], "flk.map")

eth <- as.data.frame(fread(fn, header=T, nThread = 15))
ped <- as.data.frame(fread(pe, nThread = 20))
eth <- data.frame(V1=eth[,3],V2=eth[,2])
hap <- merge(eth, ped, by = "V2")
hap <- hap[,-c(1)]
fwrite(hap, file = outpe, col.names=F, sep = " ", 
	row.names=F, quote=F, nThread = 30, buffMB = 10)
map <- as.data.frame(fread(ma, nThread = 15))
fwrite(map, file = outma, col.names=F, row.names=F, 
	quote=F, sep = " ", nThread = 30, buffMB = 10)

