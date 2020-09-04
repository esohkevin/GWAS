#!/usr/bin/env Rscript

bin <- seq(from=0.00, to=0.5, by=0.01)
frqbins <- as.data.frame(bin)
vc <- c(0)
chrom <- seq(from=1, to=22, by=1)
for (chr in 1:22) {
  f <- read.table(paste0("chr", chr, "_imputed.gen.info.maf.r2"),h=T)
  colnames(f) <- c("maf","r2")
  for(bindex in 1:(length(bin)-1)) {
      vc[bindex+1] <- (sum(f$r2[f$maf >= bin[bindex] & f$maf < bin[(bindex+1)]])/length(f$r2[f$maf >= bin[bindex] & f$maf < bin[(bindex+1)]]))
  }
  frqbins[,chrom[chr]] <- vc
}
frqbins <- cbind(bin, frqbins)
colnames(frqbins) <- c("MAF","Chr1","Chr2","Chr3","Chr4","Chr5","Chr6","Chr7","Chr8","Chr9","Chr10","Chr11","Chr12","Chr3","Chr14","Chr15","Chr16","Chr17","Chr18","Chr19","Chr20","Chr21","Chr22")

png("imputation_accuracy.png", width=17, height=18, units="cm", points=12)
  plot(frqbins$MAF, frqbins$Chr1, type="l", lty=4)
  for (chr in 3:23) { 
	lines(frqbins$MAF, frqbins[,chr], lty=4)
  }
dev.off()
