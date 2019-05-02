#!/usr/bin/Rscript

#################### Association Test Accounting for Population Structure #########################
if (!requireNamespace("qqman")) 
	install.packages("qqman", repos="http://cloud.r-project.org", ask = F)
library(qqman)

### Now read in association test data after including axes of genetic variation as covariats
# Using PC1 and PC2
psassoc=read.table("post-imput.assoc.logistic", header = T, as.is = T)

# Now assess the genomic control inflation factor
median(qchisq(psassoc[,9], df=1, lower.tail = F), na.rm = T)/0.456  # 1.077156

# Now produce association plot
#snpsofinterest=assoc2[-log10(assoc2$P)>=7,]
png("im-assoc_qc.png", res = 1200, height =3, width = 6, units = "in")
par(mfrow=c(1,1), cex=0.7, mai=c(0.5,0.3,0.5,0.3))
manhattan(psassoc, chr = "CHR", bp = "BP", p = "P", col = c("gray10", "gray60"), chrlabs = NULL,
          suggestiveline = -log10(1e-05),  genomewideline = -log10(5e-08), highlight = NULL, logp = T,
          annotatePval = NULL, annotateTop = T)
dev.off()

# Using PC1, PC5 and PC9
psassoc1=read.table("post-impc1c2.assoc.logistic", header = T, as.is = T)

# Now assess the genomic control inflation factor
median(qchisq(psassoc1[,9], df=1, lower.tail = F), na.rm = T)/0.456 # 1.061969

# Now produce association plot
#snpsofinterest=assoc2[-log10(assoc2$P)>=7,]
png("im1-assoc_qc.png", res = 1200, height = 5, width = 9, units = "in")
par(mfrow=c(1,1))
manhattan(psassoc1, chr = "CHR", bp = "BP", p = "P", col = c("gray10", "gray60"), chrlabs = NULL,
          suggestiveline = -log10(1e-05),  genomewideline = -log10(5e-08), highlight = NULL, logp = T,
          annotatePval = NULL, annotateTop = T)
dev.off()

# Using all PCs
psassoc2=read.table("post-impc1c5c9.assoc.logistic", header = T, as.is = T)

# Now assess the genomic control inflation factor
median(qchisq(psassoc2[,9], df=1, lower.tail = F), na.rm = T)/0.456

# Now produce association plot
#snpsofinterest=assoc2[-log10(assoc2$P)>=7,]
png("im2-assoc_qc.png", res = 1200, height = 5, width = 9, units = "in")
par(mfrow=c(1,1))
manhattan(psassoc2, chr = "CHR", bp = "BP", p = "P", col = c("gray10", "gray60"), chrlabs = NULL,
          suggestiveline = -log10(1e-05),  genomewideline = -log10(5e-08), highlight = NULL, logp = T,
          annotatePval = NULL, annotateTop = T)
dev.off()

# Run Association for imputed dataset using additive MOI
psassoc2=read.table("post-impc1-c10.assoc.logistic", header = T, as.is = T)
png("im-add-assoc_qc.png", res = 1200, height = 5, width = 9, units = "in")
par(mfrow=c(1,1))
manhattan(psassoc2, chr = "CHR", bp = "BP", p = "P", col = c("gray10", "gray60"), chrlabs = NULL,
          suggestiveline = -log10(1e-05),  genomewideline = -log10(5e-08), highlight = NULL, logp = T,
          annotatePval = NULL, annotateTop = T)
dev.off()


# Run Association for imputed dataset using hethom MOI
psassoc2=read.table("post-impc1-c10-hethom-noNA.assoc.logistic", header = T, as.is = T)
png("im-hethom-assoc_qc.png", res = 1200, height = 5, width = 9, units = "in")
par(mfrow=c(1,1))
manhattan(psassoc2, chr = "CHR", bp = "BP", p = "P", col = c("gray10", "gray60"), chrlabs = NULL,
          suggestiveline = -log10(1e-05),  genomewideline = -log10(5e-08), highlight = NULL, logp = T,
          annotatePval = NULL, annotateTop = T)
dev.off()


# Plot a Q-Q plot for the association analysis
png("qq_plots.png", res=1200, height=7, width=7, units="in")
par(mfrow=c(2,2))
qq(psassoc$P, main="Q-Q plot after QC")
qq(psassoc1$P, main="Q-Q plot after QC")
qq(psassoc2$P, main="Q-Q plot after QC")
dev.off()


