#!/usr/bin/env Rscript

#--- Quick plot
f <- read.table("maf.txt",h=T)
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

