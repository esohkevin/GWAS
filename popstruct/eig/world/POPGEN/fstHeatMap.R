#!/usr/bin/Rscript


fstMat <- read.table("fstMatrix.txt", header=T, as.is=T)
m <- as.matrix(fstMat[, -1])
rownames(m) <- fstMat$rows
png("fst.png", width=500, height=500, units="px", type = "cairo")
heatmap(m)
dev.off()
