#!/usr/bin/Rscript

# Save evec data into placeholder
fn = "qc-camgwas.evec"
evecDat = read.table(fn, col.names=c("Sample", "PC1", "PC2", "PC3",
				     "PC4", "PC5", "PC6", "PC7", "PC8", 
				     "PC9", "PC10", "Status"))

# Import Population groups from popstruct directory
popGroups = read.table("../../qc-camgwas.pops", col.names=c("Sample", "PopGroup"))
mergedEvecDat = merge(evecDat, popGroups, by="Sample")

png(filename = "evec1vc2.png", width = 500, height = 780, units = "px", pointsize = 12, 
    bg = "white",  res = NA, type = c("quartz"))
# type =c("cairo", "cairo-png", "Xlib", "quartz")
#png("evec1v2.png", res=1200, height=4, width=2, units="in")
par(mfrow=c(2,1))
#  cex=0.3, mai=c(0.2,0.3,0.3,0.3)
plot(evecDat$PC1, evecDat$PC2, xlab="eigenvalue1", ylab="eigenvalue2", main="Eigenanalysis With Sample Status")
d = evecDat[evecDat$Status=="Case",]
points(d$PC1, d$PC2, col=1, pch=20)
d = evecDat[evecDat$Status=="Control",]
points(d$PC1, d$PC2, col=2, pch=20)
legend("topleft", c("Case", "Control"), col=c(1,2), pch=20)
plot(mergedEvecDat$PC1, mergedEvecDat$PC2, col=mergedEvecDat$PopGroup, main="Eigenanalysis With Sample Region", xlab="eigenvalue1", ylab="eigenvalue2", pch=20)
legend("topleft", legend=levels(mergedEvecDat$PopGroup), col=1:length(levels(mergedEvecDat$PopGroup)), pch=20)
dev.off()

## Plot for 6 pairs of eigenvalues
png(filename = "eigenv1-v10.png", width = 890, height = 600, units = "px", pointsize = 12,
    bg = "white",  res = NA, type = c("cairo-png"))
par(mfrow=c(2,3))
#png("eigenv1-v10.png", res=1200, height=2, width=4, units="in")
#par(mfrow=c(2,3), cex=0.3, cex.lab=0.8, cex.axis=0.8, cex.main=0.8)
plot(evecDat$PC1, evecDat$PC2, xlab="PC1", ylab="PC2", pch=20, main="PC1 Vs PC2")
d = evecDat[evecDat$Status=="Case",]
points(d$PC1, d$PC2, col=1, pch=20)
d = evecDat[evecDat$Status=="Control",]
points(d$PC1, d$PC2, col=2, pch=20)
legend("topleft", c("Case", "Control"), col=c(1,2), pch=20, bty="n")
plot(evecDat$PC3, evecDat$PC4, xlab="PC3", ylab="PC4", pch=20, main="PC3 Vs PC4")
d = evecDat[evecDat$Status=="Case",]
points(d$PC1, d$PC2, col=1, pch=20)
d = evecDat[evecDat$Status=="Control",]
points(d$PC1, d$PC2, col=2, pch=20)
legend("topright", c("Case", "Control"), col=c(1,2), pch=20, bty="n")
plot(evecDat$PC5, evecDat$PC6, xlab="PC5", ylab="PC6", pch=20, main="PC5 Vs PC6")
d = evecDat[evecDat$Status=="Case",]
points(d$PC1, d$PC2, col=1, pch=20)
d = evecDat[evecDat$Status=="Control",]
points(d$PC1, d$PC2, col=2, pch=20)
legend("topright", c("Case", "Control"), col=c(1,2), pch=20, bty="n")
plot(evecDat$PC7, evecDat$PC8, xlab="PC7", ylab="PC8", pch=20, main="PC7 Vs PC8")
d = evecDat[evecDat$Status=="Case",]
points(d$PC1, d$PC2, col=1, pch=20)
d = evecDat[evecDat$Status=="Control",]
points(d$PC1, d$PC2, col=2, pch=20)
legend("topright", c("Case", "Control"), col=c(1,2), pch=20, bty="n")
plot(evecDat$PC9, evecDat$PC10, xlab="PC9", ylab="PC10", pch=20, main="PC9 Vs PC10")
d = evecDat[evecDat$Status=="Case",]
points(d$PC1, d$PC2, col=1, pch=20)
d = evecDat[evecDat$Status=="Control",]
points(d$PC1, d$PC2, col=2, pch=20)
legend("topright", c("Case", "Control"), col=c(1,2), pch=20, bty="n")
plot(evecDat$PC1, evecDat$PC5, xlab="PC1", ylab="PC5", pch=20, main="PC1 Vs PC5")
d = evecDat[evecDat$Status=="Case",]
points(d$PC1, d$PC2, col=1, pch=20)
d = evecDat[evecDat$Status=="Control",]
points(d$PC1, d$PC2, col=2, pch=20)
legend("topleft", c("Case", "Control"), col=c(1,2), pch=20, bty="n")
dev.off()

