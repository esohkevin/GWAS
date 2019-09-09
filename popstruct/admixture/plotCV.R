#!/usr/bin/Rscript

cv <- read.table("adm-k-parameters.txt", header=T, as.is=T)
png("kParam.png", height=14, width=14, res=100, units="cm", points=12)
plot(cv, xlab="K", ylab="Cross-validation error", pch = 20,  type="b")
dev.off()
