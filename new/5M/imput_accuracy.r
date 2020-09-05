#!/usr/bin/env Rscript

args <- commandArgs(TRUE)

if(length(args)<2) {
   print("usage: ./imput_accuracy.r [AF binsize] [file_base]")
   quit(save="no")
} else {
     if(!require(data.table))
        if(!install.packages("data.table", repos="https://cloud.r-project.org"))
     bs <- as.numeric(args[1])
     bn <- args[2]
     outpng <- paste0("imputation",bn,"accuracy.png")
     bin <- seq(from=0.00, to=0.5, by=bs)
     frqbins <- as.data.frame(bin)
     vc <- c(0)
     chrom <- seq(from=1, to=22, by=1)
     for (chr in 1:22) {
       f <- fread(paste0("chr", chr, bn),h=T)
       colnames(f) <- c("maf","r2")
       for(bindex in 1:(length(bin)-1)) {
           vc[bindex+1] <- (sum(f$r2[f$maf >= bin[bindex] & f$maf < bin[(bindex+1)]])/length(f$r2[f$maf >= bin[bindex] & f$maf < bin[(bindex+1)]]))
       }
       frqbins[,chrom[chr]] <- vc
     }
     frqbins <- cbind(bin, frqbins)
     colnames(frqbins) <- c("MAF","Chr1","Chr2","Chr3","Chr4","Chr5","Chr6","Chr7","Chr8","Chr9","Chr10","Chr11","Chr12","Chr3","Chr14","Chr15","Chr16","Chr17","Chr18","Chr19","Chr20","Chr21","Chr22")
     
     png(outpng, width=17, height=16, units="cm", res=100, points=12)
       plot(frqbins$MAF, frqbins$Chr1, xlab=paste0("Imputed MAF bin: binsize = ", bs), ylab="Mean imputation accuracy", type="l", lty=4, col=2)
       for (chr in 3:23) { 
     	lines(frqbins$MAF, frqbins[,chr], lty=4, col=2)
       }
     dev.off()
}
