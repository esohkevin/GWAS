#!/usr/bin/Rscript

# Save evec data into placeholder
fn = "qc-camgwas.evec"
evecDat = read.table(fn, col.names=c("Sample", "PC1", "PC2", "PC3",
				     "PC4", "PC5", "PC6", "PC7", "PC8", 
				     "PC9", "PC10", "Status"))

############## Import Population groups from popstruct directory ################
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
points(d$PC1, d$PC2, col=2, pch=20)
d = evecDat[evecDat$Status=="Control",]
points(d$PC1, d$PC2, col=1, pch=20)
legend("topleft", c("Case", "Control"), col=c(2,1), pch=20)
plot(mergedEvecDat$PC1, mergedEvecDat$PC2, col=mergedEvecDat$PopGroup, main="Eigenanalysis With Sample Region", xlab="eigenvalue1", ylab="eigenvalue2", pch=20)
legend("topleft", legend=levels(mergedEvecDat$PopGroup), col=1:length(levels(mergedEvecDat$PopGroup)), pch=20)
dev.off()

################### Plot for 6 pairs of eigenvalues #######################
png(filename = "eigenv1-v10.png", width = 890, height = 600, units = "px", pointsize = 12,
    bg = "white",  res = NA, type = c("cairo-png"))
par(mfrow=c(2,3))
#png("eigenv1-v10.png", res=1200, height=2, width=4, units="in")
#par(mfrow=c(2,3), cex=0.3, cex.lab=0.8, cex.axis=0.8, cex.main=0.8)
plot(evecDat$PC1, evecDat$PC2, xlab="PC1", ylab="PC2", pch=20, main="PC1 Vs PC2")
d = evecDat[evecDat$Status=="Case",]
points(d$PC1, d$PC2, col=2, pch=20)
d = evecDat[evecDat$Status=="Control",]
points(d$PC1, d$PC2, col=1, pch=20)
legend("topleft", c("Case", "Control"), col=c(2,1), pch=20, bty="n")
plot(evecDat$PC3, evecDat$PC4, xlab="PC3", ylab="PC4", pch=20, main="PC3 Vs PC4")
d = evecDat[evecDat$Status=="Case",]
points(d$PC3, d$PC4, col=2, pch=20)
d = evecDat[evecDat$Status=="Control",]
points(d$PC3, d$PC4, col=1, pch=20)
legend("topright", c("Case", "Control"), col=c(2,1), pch=20, bty="n")
plot(evecDat$PC5, evecDat$PC6, xlab="PC5", ylab="PC6", pch=20, main="PC5 Vs PC6")
d = evecDat[evecDat$Status=="Case",]
points(d$PC5, d$PC6, col=2, pch=20)
d = evecDat[evecDat$Status=="Control",]
points(d$PC5, d$PC6, col=1, pch=20)
legend("topright", c("Case", "Control"), col=c(2,1), pch=20, bty="n")
plot(evecDat$PC7, evecDat$PC8, xlab="PC7", ylab="PC8", pch=20, main="PC7 Vs PC8")
d = evecDat[evecDat$Status=="Case",]
points(d$PC7, d$PC8, col=2, pch=20)
d = evecDat[evecDat$Status=="Control",]
points(d$PC7, d$PC8, col=1, pch=20)
legend("topright", c("Case", "Control"), col=c(2,1), pch=20, bty="n")
plot(evecDat$PC9, evecDat$PC10, xlab="PC9", ylab="PC10", pch=20, main="PC9 Vs PC10")
d = evecDat[evecDat$Status=="Case",]
points(d$PC9, d$PC10, col=2, pch=20)
d = evecDat[evecDat$Status=="Control",]
points(d$PC9, d$PC10, col=1, pch=20)
legend("topright", c("Case", "Control"), col=c(2,1), pch=20, bty="n")
plot(evecDat$PC1, evecDat$PC5, xlab="PC1", ylab="PC5", pch=20, main="PC1 Vs PC5")
d = evecDat[evecDat$Status=="Case",]
points(d$PC1, d$PC5, col=2, pch=20)
d = evecDat[evecDat$Status=="Control",]
points(d$PC1, d$PC5, col=1, pch=20)
legend("topleft", c("Case", "Control"), col=c(2,1), pch=20, bty="n")
dev.off()

############# Import the data file containing ethnicity column #################
evecthn=read.table("qc-camgwas-ethni.evec", header=T, as.is=T)

######### Plot First 2 evecs with ethnicity distinction ##########
png(filename = "evec_with_ethn.png", width = 510, height = 510, units = "px", pointsize = 12,
    bg = "white",  res = NA, type = c("quartz"))
plot(evecthn$PC1, evecthn$PC2, col=as.factor(evecthn$ethnicity), main="Eigenanalysis With Ethnicity", 
     xlab="eigenvalue1", ylab="eigenvalue2", pch=20)
legend("topleft", legend=levels(as.factor(evecthn$ethnicity)), 
       col=1:length(levels(as.factor(evecthn$ethnicity))), pch=20)
dev.off()

##### Project Case-Control status and Ethnicity Along the three interesting eigenvalues ######
png(filename = "eigenv-select.png", width = 890, height = 600, units = "px", pointsize = 12,
    bg = "white",  res = NA, type = c("cairo-png"))
par(mfrow=c(2,3))

# Pour Ethnic affiliations
plot(evecthn$PC1, evecthn$PC2, xlab="PC1", ylab="PC2", pch=20, main="PC1 Vs PC2 - Ethnicity")
d = evecthn[evecthn$ethnicity=="BA",]
points(d$PC1, d$PC2, col=2, pch=20)
d = evecthn[evecthn$ethnicity=="SB",]
points(d$PC1, d$PC2, col=1, pch=20)
d = evecthn[evecthn$ethnicity=="FO",]
points(d$PC1, d$PC2, col=3, pch=20)
legend("topleft", c("BA", "SB", "FO"), col=c(2,1,3), pch=20, bty="n")
plot(evecthn$PC3, evecthn$PC4, xlab="PC3", ylab="PC4", pch=20, main="PC3 Vs PC4 - Ethnicity")
d = evecthn[evecthn$ethnicity=="BA",]
points(d$PC3, d$PC4, col=2, pch=20)
d = evecthn[evecthn$ethnicity=="SB",]
points(d$PC3, d$PC4, col=1, pch=20)
d = evecthn[evecthn$ethnicity=="FO",]
points(d$PC3, d$PC4, col=3, pch=20)
legend("topright", c("BA", "SB", "FO"), col=c(2,1,3), pch=20, bty="n")
plot(evecthn$PC1, evecthn$PC5, xlab="PC1", ylab="PC5", pch=20, main="PC1 Vs PC5 - Ethnicity")
d = evecthn[evecthn$ethnicity=="BA",]
points(d$PC1, d$PC2, col=2, pch=20)
d = evecthn[evecthn$ethnicity=="SB",]
points(d$PC1, d$PC5, col=1, pch=20)
d = evecthn[evecthn$ethnicity=="FO",]
points(d$PC1, d$PC5, col=3, pch=20)
legend("topleft", c("BA", "SB", "FO"), col=c(2,1,3), pch=20, bty="n")

# Involving mixed reports
plot(mergedEvecDat$PC1, mergedEvecDat$PC2, xlab="PC1", ylab="PC2", pch=20, main="PC1 Vs PC2 - Population Group")
d = mergedEvecDat[mergedEvecDat$PopGroup=="BUE",]
points(d$PC1, d$PC2, col=4, pch=20)
d = mergedEvecDat[mergedEvecDat$PopGroup=="DOU",]
points(d$PC1, d$PC2, col=5, pch=20)
d = mergedEvecDat[mergedEvecDat$PopGroup=="YDE",]
points(d$PC1, d$PC2, col=6, pch=20)
legend("topleft", c("BUE", "DOU", "YDE"), col=c(4,5,6), pch=20, bty="n")
plot(mergedEvecDat$PC3, mergedEvecDat$PC4, xlab="PC3", ylab="PC4", pch=20, main="PC3 Vs PC4 - Population Group")
d = mergedEvecDat[mergedEvecDat$PopGroup=="BUE",]
points(d$PC3, d$PC4, col=4, pch=20)
d = mergedEvecDat[mergedEvecDat$PopGroup=="DOU",]
points(d$PC3, d$PC4, col=5, pch=20)
d = mergedEvecDat[mergedEvecDat$PopGroup=="YDE",]
points(d$PC3, d$PC4, col=6, pch=20)
legend("topright", c("BUE", "DOU", "YDE"), col=c(4,5,6), pch=20, bty="n")
plot(mergedEvecDat$PC1, mergedEvecDat$PC5, xlab="PC1", ylab="PC5", pch=20, main="PC1 Vs PC5 - Population Group")
d = mergedEvecDat[mergedEvecDat$PopGroup=="BUE",]
points(d$PC1, d$PC5, col=4, pch=20)
d = mergedEvecDat[mergedEvecDat$PopGroup=="DOU",]
points(d$PC1, d$PC5, col=5, pch=20)
d = mergedEvecDat[mergedEvecDat$PopGroup=="YDE",]
points(d$PC1, d$PC5, col=6, pch=20)
legend("topleft", c("BUE", "DOU", "YDE"), col=c(4,5,6), pch=20, bty="n")

dev.off()

