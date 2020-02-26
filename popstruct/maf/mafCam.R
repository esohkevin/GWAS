#!/usr/bin/env Rscript

args <- commandArgs(TRUE)

if (length(args) < 3 ) {
   print("",quote=F)
   print("Usage: ./mafStats.R [ maf_file] [out_prefix] [threads]",quote=F)
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

     frq <- args[1]
     fout <- paste0(args[2],".txt")
     fimage <- paste0(args[2],".png")
     thr <- as.numeric(args[3])
     f <- fread(frq,h=T,nThread=thr)


     #--- Quick plot
     #f <- read.table("maf.txt",h=T)
     png("camMaf.png", height=10, width=10, units="cm", res=200, points=8)
     plot(0, 0, xlim=c(0,1), ylim=c(0,0.5),
               type="n",xlab="MAF bin", ylab="Proportion of SNPs",
               main="Minor allele frequency spectrum")
     pcol <- c("green","red","blue")
     for (i in 2:ncol(f)) {
       if (i < ncol(f)) {
         lines(data.frame(f$bin, f[i]), lty=1, lwd=1, col=pcol[i-1])
       }
       else {
         lines(data.frame(f$bin, f[i]), lty=2, lwd=1, col=pcol[i-1])
       }
     }
     legend("topright", legend=c("BA","FO","SB"), col=c("green","red","blue"), lty=c(1,1,2), bty="n")
     dev.off()
}
