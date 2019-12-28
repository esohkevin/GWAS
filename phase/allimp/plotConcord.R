#!/usr/bin/env Rscript

require(qqman)
require(data.table)
f <- fread("mergeConcord.txt", h=T, nThread=30, data.table=F)
colnames(f) <- c("CHR","SNP","BP","a0","a1","exp_freq_a1","info","certainty","type", "info_type0", "P", "r2_type0")
png("allConcord.png", height=450, width=550, points=10, units='cm', res=100)
manhattan(f)
dev.off()
