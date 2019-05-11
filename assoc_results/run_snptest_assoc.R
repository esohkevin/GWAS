#!/usr/bin/Rscript

assoc.imp.snptest <- read.table("snptest_assoc_test_imp.txt", header=T, as.is=T)
png("imp_snptest_assoc.png")
plot(assoc.imp.snptest$position, 
	assoc.imp.snptest$bayesian_add_log10_bf, 
	ylim=c(0,10), main = "Typed + Imputed SNPs", 
	xlab="Position", ylab="log10 Bayes factor", 
	col = 1+1*(assoc.imp.snptest[,1] == "---"), pch=20)
legend("topleft", col = c(1,2), c("Typed", "Imputed"), pch=20)
dev.off()
