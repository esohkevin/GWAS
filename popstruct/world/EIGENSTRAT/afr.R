#!/usr/bin/env R

library("colorspace") 

evecDat <- read.table("afr-data.pca.evec", col.names=c("Sample","PC1","PC2","PC3","PC4","PC5","PC6","PC7","PC8","PC9","PC10","Status"), as.is=T)
popGrps <- read.table("africaGrops.txt", col.names=c("Sample","Pop","PopGroup"), as.is=T)
pcaDat <- merge(evecDat, popGrps, by="Sample")
write.table(pcaDat, file="afr-data.pca.txt", col.names=T, row.names=F, quote=F, sep="\t")

evecDat <- read.table("afr-data.pca.txt", header=T, as.is=T)
png("AfrPCA.png", height=640, width=550, units="px", points=16, res=NA)
par(mfrow=c(2,1), cex=0.8, cex.axis=1, cex.lab=1.2)
par(fig=c(0,1,0.35,1), bty="o", mar=c(4,4,3,2))
plot(evecDat[,2], evecDat[,3], xlab="PC1 (Africa-only)", ylab="PC2", type="n")
for(i in 1:nrow(evecDat)){                                                                      
if(evecDat[i,13]=='BA') points(evecDat[i,2], evecDat[i,3], col="deeppink", pch=15)
if(evecDat[i,13]=='SB') points(evecDat[i,2], evecDat[i,3], col="indianred4", pch=15)
if(evecDat[i,13]=='FO') points(evecDat[i,2], evecDat[i,3], col="purple4", pch=15)
if(evecDat[i,13]=='ACB') points(evecDat[i,2], evecDat[i,3], col="aquamarine", pch=15)
if(evecDat[i,13]=='ASW') points(evecDat[i,2], evecDat[i,3], col="aquamarine4", pch=15)
if(evecDat[i,13]=='ESN') points(evecDat[i,2], evecDat[i,3], col="chartreuse", pch=15)
if(evecDat[i,13]=='YRI') points(evecDat[i,2], evecDat[i,3], col="chartreuse4", pch=15)
if(evecDat[i,13]=='MSL') points(evecDat[i,2], evecDat[i,3], col="deepskyblue", pch=15)
if(evecDat[i,13]=='GWD') points(evecDat[i,2], evecDat[i,3], col="deepskyblue4", pch=15)
if(evecDat[i,13]=='LWK') points(evecDat[i,2], evecDat[i,3], col="goldenrod2", pch=15)
}
par(fig=c(0,1,0,0.45), new=T, bty="o", mar=c(5,4,4,2))
plot.new()
legend("center", c("BA=BANTU","SB=SEMI-BANTU","FO=FULBE","ACB=African Caribbean in Barbados",
		   "ASW=African-American SW","ESN=ESAN in Nigeria","YRI=Yoruba in Ibadan, Nigeria",
		   "MSL=Mende in Sierra Leone", "GWD=Gambian Mandinka", "LWK=Luhya in Webuye, Kenya"), 
       		col=c("deeppink","indianred4", "purple4","aquamarine","aquamarine4","chartreuse","chartreuse4",
		   "deepskyblue","deepskyblue4","goldenrod2"), 
       		pch=c(15,15,15,16,16,17,17,18,20,23), 
		ncol=2, bty="n", cex=0.8)
dev.off()

