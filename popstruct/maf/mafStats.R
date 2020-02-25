#!/usr/bin/env Rscript

args <- commandArgs(TRUE)

if (length(args) < 2 ) {
   print("",quote=F)
   print("Usage: ./mafStats.R [ maf_file] [out_prefix]",quote=F)
   print("",quote=F)
   print("maf_file: File with three columns with PLINK freq-type header [SNP CLST MAF]",quote=F)
   print("(col1=snpid/rsid, col2=PopName, col3=MAF)",quote=F)
   print("",quote=F)
   quit(save="no")
} else {
   
     if(!require(ggplot2)){
	     install.packages("ggplot2", repo="https.cloud.r-project.org")
     }
     if(!require(data.table)){
             install.packages("data.table", repo="https.cloud.r-project.org")
     }
     if(!require(colorspace)){
             install.packages("colorspace", repo="https.cloud.r-project.org")
     }
     if(!require(RColorBrewer)){
             install.packages("RColorBrewer", repo="https.cloud.r-project.org")
     }
     require(data.table)
     require(colorspace)
     require(RColorBrewer)
     
     f <- args[1]
     fout <- paste0(args[2],".txt")
     fimage <- paste0(args[2],".png")
     
     frq <- fread(f,h=T,nThread=10)

     #png("maf.png", height=15, width=15, units="cm", res=100, points=12)
     #hist(frq$MAF[frq$CLST=="SB"], breaks=40, xlim = c(0,0.50), ylim=c(0,300000), xlab="MAF bin", main = "MAF Spectrum", col = pcol[1])
     #hist(frq$MAF[frq$CLST=="BA"], breaks=40, xlim=c(0,0.50), labels =F, add=T, col = pcol[2]) #breaks = 200,
     #hist(frq$MAF[frq$CLST=="FO"], breaks=40, xlim=c(0,0.50), labels =F, add=T, col = pcol[3])
     ##abline(v=c(0.01,0.05), col=c(2,4,1), lty=2)
     #legend("topright", legend=c("SB","BA","FO"), col=c(pcol[1],pcol[2],pcol[3]), lty=1)
     #dev.off()
     
     print(paste0("Maximum MAF: ", max(frq$MAF)), quote=F)
     print(paste0("Minimum MAF: ", min(frq$MAF)), quote=F)
     bin <- c(0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 1)
     frqbins <- as.data.frame(bin)
     pops <- unique(frq$CLST)
     print(paste0("# Populations: ", length(pops)), quote=F)
     n <- length(pops)
     pcol <- RColorBrewer::brewer.pal(n, "Dark2")
     for (popindex in 1:n) {
	     frqbins[,pops[popindex]] <- c(length(unique(frq$SNP[frq$MAF < 0.1 & frq$CLST == pops[popindex]]))/length(unique(frq$SNP)),
                length(unique(frq$SNP[frq$MAF >= 0.1 & frq$MAF < 0.2 & frq$CLST == pops[popindex]]))/length(unique(frq$SNP)),
                length(unique(frq$SNP[frq$MAF >= 0.2 & frq$MAF < 0.3 & frq$CLST == pops[popindex]]))/length(unique(frq$SNP)),
                length(unique(frq$SNP[frq$MAF >= 0.3 & frq$MAF < 0.4 & frq$CLST == pops[popindex]]))/length(unique(frq$SNP)),
                length(unique(frq$SNP[frq$MAF >= 0.4 & frq$MAF < 0.5 & frq$CLST == pops[popindex]]))/length(unique(frq$SNP)),
                length(unique(frq$SNP[frq$MAF >= 0.5 & frq$MAF < 0.6 & frq$CLST == pops[popindex]]))/length(unique(frq$SNP)),
                length(unique(frq$SNP[frq$MAF >= 0.6 & frq$MAF < 0.7 & frq$CLST == pops[popindex]]))/length(unique(frq$SNP)),
                length(unique(frq$SNP[frq$MAF >= 0.7 & frq$MAF < 0.8 & frq$CLST == pops[popindex]]))/length(unique(frq$SNP)),
                length(unique(frq$SNP[frq$MAF >= 0.8 & frq$MAF <= 1 & frq$CLST == pops[popindex]]))/length(unique(frq$SNP)))
     }
     
     write.table(frqbins, file=fout,col.name=T, row.name=F, sep="\t",quote=F)
     
     print(paste0("Frqbins #col: ", ncol(frqbins)), quote=F)
     #maxbin <- max(frqbins$bin)
     png(fimage, height=10, width=10, units="cm", res=200, points=8)
     plot(0, 0, xlim=c(0,1), ylim=c(0,0.5),
          type="n",xlab="MAF bin", ylab="Proportion of SNPs",
          main="Minor allele frequency spectrum")
     frqs <- frqbins[,-c(1)]
     for (indx in 1:ncol(frqs)) {
	     print(paste0("Plotting ", pops[indx]), quote=F)
             frqplot = data.frame(c(frqbins[1], frqs[indx])) #data.frame(c(f[1],f[2]))
             lines(frqplot, col=pcol[indx], type="l", lwd=1, lty=1)
     }
     legend("topright", legend=pops, col=pcol[1:ncol(frqs)], lty=1, lwd=1, bty="n") #legend=as.factor(names(frqbins[,-c(1)]))
     dev.off()
}

#--- Quick plot
#f <- read.table("maf.txt",h=T)
#png("camMaf.png", height=15, width=15, units="cm", res=100, points=12)
#plot(0, 0, xlim=c(0.1,1), ylim=c(0,0.5),
#          type="n",xlab="MAF bin", ylab="Proportion of SNPs",
#          main="Minor allele frequency spectrum")
#plot(0,0,type="n", xlim=c(0,1), ylim=c(0,0.5))
#pcol <- c("green","red","blue")
#for (i in 2:ncol(f)) {
#lines(data.frame(f$bin, f[i]), lty=1, lwd=1, col=pcol[i-1])
#}
#legend("topright", legend=c("BA","FO","SB"), col=c("green","red","blue"), lty=1, bty="n")
#dev.off()

