#!/usr/bin/Rscript

# Check installation of qqman and load it if installed
if (!requireNamespace("qqman"))
        install.packages("qqman", repos="http://cloud.r-project.org", ask = F)
library(qqman)

#################### Association Test Accounting for Population Structure #########################
# Using PC1, PC5 and PC9
psassoc1=read.table("eig-qc-camgwasC1C4C5.assoc.logistic", header = T, as.is = T)

# Now assess the genomic control inflation factor
median(qchisq(psassoc1[,9], df=1, lower.tail = F), na.rm = T)/0.456 # 1.061969

# Now produce association plot
#snpsofinterest=psassoc1[-log10(psassoc1$P)>=4,]
#png("ps1-assoc_qc.png", res = 1200, height = 4, width = 7, units = "in")
png(filename = "eigC145-assoc-add.png", width = 750, height = 450, units = "px", pointsize = 12,
    bg = "white",  res = NA)
par(mfrow=c(1,1))
manhattan(psassoc1, chr = "CHR", bp = "BP", p = "P", col = c("gray10", "gray60"), chrlabs = NULL,
          suggestiveline = -log10(1e-05),  genomewideline = -log10(5e-08), highlight = snpsofinterest$SNP, logp = T,
          annotatePval = 1e-06, annotateTop = T)
dev.off()

# Using all PCs - Additive
psassoc2=read.table("eig-qc-camgwasC1-C10-add.assoc.logistic", header = T, as.is = T)

# Now assess the genomic control inflation factor
median(qchisq(psassoc2[,9], df=1, lower.tail = F), na.rm = T)/0.456

# Now produce association plot
#snpsofinterest=psassoc2[-log10(psassoc2$P)>=4,]
png(filename = "eigC1-10-assoc-add.png", width = 750, height = 450, units = "px", pointsize = 12,
    bg = "white",  res = NA)
par(mfrow=c(1,1))
manhattan(psassoc2, chr = "CHR", bp = "BP", p = "P", col = c("gray10", "gray60"), chrlabs = NULL,
          suggestiveline = -log10(1e-05),  genomewideline = -log10(5e-08), highlight = snpsofinterest$SNP, logp = T,
          annotatePval = 1e-6, annotateTop = T)
dev.off()

# Using all PCs - hethom
psassoc3=read.table("eig-qc-camgwasC1-C10-hethom.assoc.logistic", header = T, as.is = T)

# Now assess the genomic control inflation factor
median(qchisq(psassoc3[,9], df=1, lower.tail = F), na.rm = T)/0.456

# Now produce association plot
#snpsofinterest=psassoc3[-log10(psassoc3$P)>=4,]
png(filename = "eigC1-10-assoc-hethom.png", width = 750, height = 450, units = "px", pointsize = 12, bg = "white",  res = NA)
par(mfrow=c(1,1))
manhattan(psassoc3, chr = "CHR", bp = "BP", p = "P", col = c("gray10", "gray60"), chrlabs = NULL,
          suggestiveline = -log10(1e-05),  genomewideline = -log10(5e-08), highlight = snpsofinterest$SNP, logp = T,
          annotatePval = 1e-6, annotateTop = T)
dev.off()

# Using all PCs
psassoc4=read.table("eig-qc-camgwasC1-C10-rec.assoc.logistic", header = T, as.is = T)

# Now assess the genomic control inflation factor
median(qchisq(psassoc4[,9], df=1, lower.tail = F), na.rm = T)/0.456

# Now produce association plot
#snpsofinterest=psassoc4[-log10(psassoc4$P)>=4,]
png(filename = "eigC1-10-assoc-rec.png", width = 750, height = 450, units = "px", pointsize = 12,
    bg = "white",  res = NA)
par(mfrow=c(1,1))
manhattan(psassoc4, chr = "CHR", bp = "BP", p = "P", col = c("gray10", "gray60"), chrlabs = NULL,
          suggestiveline = -log10(1e-05),  genomewideline = -log10(5e-08), highlight = snpsofinterest$SNP, logp = T,
          annotatePval = 1e-6, annotateTop = T)
dev.off()

# Using all PCs
psassoc5=read.table("eig-qc-camgwasC1-C10-dom.assoc.logistic", header = T, as.is = T)

# Now assess the genomic control inflation factor
median(qchisq(psassoc5[,9], df=1, lower.tail = F), na.rm = T)/0.456

# Now produce association plot
#snpsofinterest=psassoc5[-log10(psassoc5$P)>=4,]
png(filename = "eigC1-10-assoc-dom.png", width = 750, height = 450, units = "px", pointsize = 12,
    bg = "white",  res = NA)
par(mfrow=c(1,1))
manhattan(psassoc5, chr = "CHR", bp = "BP", p = "P", col = c("gray10", "gray60"), chrlabs = NULL,
          suggestiveline = -log10(1e-05),  genomewideline = -log10(5e-08), highlight = snpsofinterest$SNP, logp = T,
          annotatePval = 1e-6, annotateTop = T)
dev.off()

# Plot a Q-Q plot for the association analysis
png(filename = "eig-qq_plots.png", width = 700, height = 500, units = "px", pointsize = 12,
    bg = "white",  res = NA)
par(mfrow=c(2,2))
qq(psassoc1$P, main="Q-Q plot after QC")
qq(psassoc2$P, main="Q-Q plot after QC")
qq(psassoc4$P, main="Q-Q plot after QC")
qq(psassoc5$P, main="Q-Q plot after QC")
dev.off()


