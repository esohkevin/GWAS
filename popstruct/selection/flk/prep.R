#!/usr/bin/Rscript

require(data.table)

fn <- "perm.txt"

eth <- as.data.frame(fread(fn, header=T, nThread = 15))
ped <- as.data.frame(fread("cam.ped", nThread = 20))
eth <- data.frame(V1=eth[,3],V2=eth[,2])
hap <- merge(eth, ped, by = "V2")
hap <- hap[,-c(1)]
fwrite(hap, file = "camflk.ped", col.names=F, sep = " ", 
	row.names=F, quote=F, nThread = 30, buffMB = 10)
map <- as.data.frame(fread("cam.map", nThread = 15))
fwrite(map, file = "camflk.map", col.names=F, row.names=F, 
	quote=F, sep = " ", nThread = 30, buffMB = 10)

