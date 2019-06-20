#!/usr/bin/env R

library("colorspace") 

evecDat <- read.table("afr-data.pca.txt", header=T, as.is=T)
png("AfrPCA.png", height=640, width=550, units="px", points=14, res=NA)
par(mfrow=c(2,1), cex=0.8, cex.axis=1, cex.lab=1.2)
par(fig=c(0,1,0.35,1), bty="o", mar=c(4,4,3,2))
plot(evecDat[,2], evecDat[,3], xlab="PC1", ylab="PC2", type="n")
for(i in 1:nrow(evecDat)){                                                                      
if(evecDat[i,12]=='BA') points(evecDat[i,2], evecDat[i,3], col="deeppink", pch=15)
if(evecDat[i,12]=='SB') points(evecDat[i,2], evecDat[i,3], col="deeppink2", pch=15)
if(evecDat[i,12]=='FO') points(evecDat[i,2], evecDat[i,3], col="deeppink4", pch=15)
if(evecDat[i,12]=='ACB') points(evecDat[i,2], evecDat[i,3], col="aquamarine", pch=15)
if(evecDat[i,12]=='ASW') points(evecDat[i,2], evecDat[i,3], col="aquamarine4", pch=15)
if(evecDat[i,12]=='ESN') points(evecDat[i,2], evecDat[i,3], col="chartreuse", pch=15)
if(evecDat[i,12]=='YRI') points(evecDat[i,2], evecDat[i,3], col="chartreuse4", pch=15)
if(evecDat[i,12]=='MSL') points(evecDat[i,2], evecDat[i,3], col="deepskyblue", pch=15)
if(evecDat[i,12]=='GWD') points(evecDat[i,2], evecDat[i,3], col="deepskyblue4", pch=15)
if(evecDat[i,12]=='LWK') points(evecDat[i,2], evecDat[i,3], col="goldenrod2", pch=15)
}
par(fig=c(0,1,0,0.45), new=T, bty="o", mar=c(5,4,4,2))
plot.new()
legend("center", c("BA=BANTU","SB=SEMI-BANTU","FO=FULBE","ACB=African Caribbean in Barbados",
		   "ASW=African-American SW","ESN=ESAN in Nigeria","YRI=Yoruba in Ibadan, Nigeria",
		   "MSL=Mende in Sierra Leone", "GWD=Gambian Mandinka", "LWK=Luhya in Webuye, Kenya"), 
       		col=c("deeppink","deeppink2", "deeppink4","aquamarine","aquamarine4","chartreuse","chartreuse4",
		   "deepskyblue","deepskyblue4","goldenrod2"), 
       		pch=c(15,15,15,16,16,17,17,18,20,23), 
		ncol=3, bty="n", cex=0.8)
dev.off()

