#!/usr/bin/env Rscript

sb <- read.table("sb_ba.pca.txt",h=T)
phe <- read.table("../analysis/qc-camgwas-updated.fam", h=F)
ph <- phe[,c(1,6)]
colnames(ph) <- c("FID","CC")
sbph <- merge(sb, ph, by="FID")
write.table(sbph, file="sb_ba.pca.glm.txt", col.names=T, row.names=F, quote=F)

summary(glm(as.factor(sbph[,14])~sbph[,3]+sbph[,4]+sbph[,5]+sbph[,6]+
              sbph[,7]+sbph[,8]+sbph[,9]+sbph[,10]+sbph[,11]+sbph[,12],family = "binomial"))
