#!/usr/bin/Rscript


args <- commandArgs(TRUE)
fstMat <- read.table(args[1], header=T, as.is=T)
m <- as.matrix(fstMat[, -1])
rownames(m) <- fstMat$rows
png(args[2], width=680, height=680, units="px", type="cairo", points=14)
heatmap(m)
dev.off()
