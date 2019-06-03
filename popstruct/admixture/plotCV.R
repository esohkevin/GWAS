#!/usr/bin/Rscript

cv <- read.table("adm-k-parameters.txt", header=T, as.is=T)
png("kParam.png", height=300, width=300, units="px")
plot(cv, xlab="K", ylab="Cross-validation error", pch = 12)
dev.off()
