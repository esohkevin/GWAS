#!/usr/bin/Rscript


args <- commandArgs(TRUE)
fstMat <- read.table(args[1], header=T, as.is=T)
m <- as.matrix(fstMat[, -1])
rownames(m) <- fstMat$rows
png(args[2], width=680, height=680, units="px", type="cairo", points=14)
heatmap(m)
dev.off()


afrMat <- read.table("afrMatrix.txt", header=T, as.is=T)
a <- as.matrix(afrMat[, -1])
rownames(a) <- afrMat$rows
png("afrFst.png", width=680, height=680, units="px", type="cairo", points=14)
heatmap(a)
dev.off()
