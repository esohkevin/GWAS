#!/usr/bin/Rscript

# Check installation of qqman and load it if installed
if (!requireNamespace("qqman"))
        install.packages("qqman", repos="http://cloud.r-project.org", ask = F)
library(qqman)

#################### Association Test Accounting for Population Structure #########################
### Now read in association test data after including axes of genetic variation as covariats
# Using PC1 and PC2
psassoc=read.table("ps-qc-camgwas.assoc.logistic", header = T, as.is = T)

# Now assess the genomic control inflation factor
median(qchisq(psassoc[,9], df=1, lower.tail = F), na.rm = T)/0.456  # 1.077156

# Now produce association plot
snpsofinterest=psassoc[-log10(psassoc$P)>=7,]
#png("ps-assoc_qc.png", res = 1200, height = 4, width = 7, units = "in")
png(filename = "ps-assoc_qc.png", width = 750, height = 450, units = "px", pointsize = 12,
    bg = "white",  res = NA, type = c("quartz"))
par(mfrow=c(1,1))
manhattan(psassoc, chr = "CHR", bp = "BP", p = "P", col = c("gray10", "gray60"), chrlabs = NULL,
          suggestiveline = -log10(1e-05),  genomewideline = -log10(5e-08), highlight = snpsofinterest$SNP, logp = T,
          annotatePval = 1e-06, annotateTop = T)
dev.off()

# Using PC1, PC5 and PC9
psassoc1=read.table("ps1-qc-camgwas.assoc.logistic", header = T, as.is = T)

# Now assess the genomic control inflation factor
median(qchisq(psassoc1[,9], df=1, lower.tail = F), na.rm = T)/0.456 # 1.061969

# Now produce association plot
snpsofinterest=psassoc1[-log10(psassoc1$P)>=7,]
#png("ps1-assoc_qc.png", res = 1200, height = 4, width = 7, units = "in")
png(filename = "ps1-assoc_qc.png", width = 750, height = 450, units = "px", pointsize = 12,
    bg = "white",  res = NA, type = c("quartz"))
par(mfrow=c(1,1))
manhattan(psassoc1, chr = "CHR", bp = "BP", p = "P", col = c("gray10", "gray60"), chrlabs = NULL,
          suggestiveline = -log10(1e-05),  genomewideline = -log10(5e-08), highlight = snpsofinterest$SNP, logp = T,
          annotatePval = 1e-06, annotateTop = T)
dev.off()

# Using all PCs
psassoc2=read.table("ps2-qc-camgwas.assoc.logistic", header = T, as.is = T)

# Now assess the genomic control inflation factor
median(qchisq(psassoc2[,9], df=1, lower.tail = F), na.rm = T)/0.456

# Now produce association plot
snpsofinterest=psassoc2[-log10(psassoc2$P)>=7,]
#png("ps2-assoc_qc.png", res = 1200, height = 4, width = 7, units = "in")
png(filename = "ps2-assoc_qc.png", width = 750, height = 450, units = "px", pointsize = 12,
    bg = "white",  res = NA, type = c("quartz"))
par(mfrow=c(1,1))
manhattan(psassoc2, chr = "CHR", bp = "BP", p = "P", col = c("gray10", "gray60"), chrlabs = NULL,
          suggestiveline = -log10(1e-05),  genomewideline = -log10(5e-08), highlight = snpsofinterest$SNP, logp = T,
          annotatePval = 1e-6, annotateTop = T)
dev.off()

# Plot a Q-Q plot for the association analysis
#png("qq_plots.png", res=1200, height=6, width=6, units="in")
png(filename = "qq_plots.png", width = 700, height = 500, units = "px", pointsize = 12,
    bg = "white",  res = NA, type = c("quartz"))
par(mfrow=c(2,2))
qq(psassoc$P, main="Q-Q plot after QC")
qq(psassoc1$P, main="Q-Q plot after QC")
qq(psassoc2$P, main="Q-Q plot after QC")
dev.off()


