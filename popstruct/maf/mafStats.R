#!/bin/bash

maf <- read.table("camall.frq.strat", header = T, as.is = T)

hbb <- data.frame(maf[4155094:4155193,])
png("mafHbbAfr.png", height=500, width=680, units="px")
plot(hbb$SNP[hbb$CLST=="CAM"], hbb$MAF[hbb$CLST=="CAM"], ylim=c(0,1), xlab="Chr11 BP", ylab="%MAF", col="black", pch=20, type="o")
lines(hbb$SNP[hbb$CLST=="YRI"], hbb$MAF[hbb$CLST=="YRI"], col="red", pch=20, type="o")
lines(hbb$SNP[hbb$CLST=="GWD"], hbb$MAF[hbb$CLST=="GWD"], col="green", pch=20, type="o")
lines(hbb$SNP[hbb$CLST=="LWK"], hbb$MAF[hbb$CLST=="LWK"], col="blue", pch=20, type="o")
abline(h=0, lty=2, col="grey")
legend("topleft", col=c("black", "red", "green", "blue"), legend=c("CAM", "YRI", "GWD", "LWK"), pch=20, bty="n", cex=0.7)
dev.off()

# Plot for non-African pops separately
png("mafHbbNonAfr.png", height=500, width=680, units="px")
plot(hbb$SNP[hbb$CLST=="CAM"], hbb$MAF[hbb$CLST=="CAM"], ylim=c(0,1), xlab="Chr11 BP", ylab="%MAF", col="black", pch=20, type="o")
lines(hbb$SNP[hbb$CLST=="GBR"], hbb$MAF[hbb$CLST=="GBR"], col="red", pch=20, type="o")
lines(hbb$SNP[hbb$CLST=="CHB"], hbb$MAF[hbb$CLST=="CHB"], col="green", pch=20, type="o")
lines(hbb$SNP[hbb$CLST=="PUR"], hbb$MAF[hbb$CLST=="PUR"], col="blue", pch=20, type="o")
abline(h=0, lty=2, col="grey")
legend("topleft", col=c("black", "red", "green", "blue"), legend=c("CAM", "GBR", "CHB", "PUR"), pch=20, bty="n", cex=0.7)
dev.off()


#png(filename = "mafWorld.png", height = 480, width = 460, units = "px")
#par(mfrow=c(2,2))
#hist(maf$MAF[maf$CLST=="GWD"], ylab = "SNPs #", xlab = "MAF", main = "GWD", ylim=c(0,90000), breaks="Scott")
#abline(v=c(0.01,0.05), lty=2, col=c("red","blue"))
#hist(maf$MAF[maf$CLST=="CAM"], ylab = "SNPs #", xlab = "MAF", main = "CAM", ylim=c(0,90000), breaks="Scott")
#abline(v=c(0.01,0.05), lty=2, col=c("red","blue"))
#hist(maf$MAF[maf$CLST=="LWK"], ylab = "SNPs #", xlab = "MAF", main = "LWK", ylim=c(0,90000), breaks="Scott")
#abline(v=c(0.01,0.05), lty=2, col=c("red","blue"))
#hist(maf$MAF[maf$CLST=="YRI"], ylab = "SNPs #", xlab = "MAF", main = "YRI", ylim=c(0,90000), breaks="Scott")
#abline(v=c(0.01,0.05), lty=2, col=c("red","blue"))
#dev.off()

#hist(maf$MAF[maf$CLST=="ASW"], ylab = "SNPs #", xlab = "MAF", main = "ASW", breaks="Scott")
#abline(v=c(0.01,0.05), lty=2, col=c("red","blue"))
#hist(maf$MAF[maf$CLST=="GBR"], ylab = "SNPs #", xlab = "MAF", main = "GBR", breaks="Scott")
#abline(v=c(0.01,0.05), lty=2, col=c("red","blue"))
#dev.off()

# Cameroon-only SNPs


## Examining minor allele frequency
#camFreq <- read.table("cam.frq", header = T, as.is = T)
#yriFreq <- read.table("yri.frq", header = T, as.is = T)
#gwdFreq <- read.table("gwd.frq", header = T, as.is = T)
#lwkFreq <- read.table("lwk.frq", header = T, as.is = T)
#gbrFreq <- read.table("gbr.frq", header = T, as.is = T)
#chbFreq <- read.table("chb.frq", header = T, as.is = T)
#
##my_color= ifelse(my_hist$breaks < -0.1, rgb(0.2,0.8,0.5,0.5) , 
##		ifelse (my_hist$breaks >=0.5, "purple", rgb(0.2,0.2,0.2,0.2) ))
#
#png(filename = "worldMAF.png", height = 480, width = 700, units = "px")
#par(mfrow=c(2,3))
#hist(gwdFreq$MAF, ylab = "SNPs #", xlab = "MAF", main = "GWD", breaks="Scott", ylim=c(0,50000),)
#abline(v=c(0.01,0.05), lty=2, col=c("red","blue"))
#hist(camFreq$MAF, ylab = "SNPs #", xlab = "MAF", main = "CAM", breaks="Scott", ylim=c(0,50000),)
#abline(v=c(0.01,0.05), lty=2, col=c("red","blue"))
#hist(lwkFreq$MAF, ylab = "SNPs #", xlab = "MAF", main = "LWK", breaks="Scott", ylim=c(0,50000),)
#abline(v=c(0.01,0.05), lty=2, col=c("red","blue"))
#hist(yriFreq$MAF, ylab = "SNPs #", xlab = "MAF", main = "YRI", breaks="Scott", ylim=c(0,50000),)
#abline(v=c(0.01,0.05), lty=2, col=c("red","blue"))
#hist(gbrFreq$MAF, ylab = "SNPs #", xlab = "MAF", main = "GBR", breaks="Scott")
#abline(v=c(0.01,0.05), lty=2, col=c("red","blue"))
#hist(chbFreq$MAF, ylab = "SNPs #", xlab = "MAF", main = "CHB", breaks="Scott")
#abline(v=c(0.01,0.05), lty=2, col=c("red","blue"))
#dev.off()


