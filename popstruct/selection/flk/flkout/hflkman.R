#!/usr/bin/Rscript

#--- hapFLK manhattan plots for chr1-22
for (i in 1:22) {
  f <- fread(paste0("cam-chr",i,"flk.flk"), data.table=F, h=T)
  if(i==1){flk<-f}else{flk<-rbind(flk,f)}
  h <- fread(paste0("cam-chr",i,"flk.hapflk"), data.table=F, h=T)
  if(i==1){hflk<-h}else{hflk<-rbind(hflk,h)}
}

png("hflk.png", height=1000, width=480, units="cm", res=100, pointsize= 12)
par(mforw=c(2,1))
#--- FLK manhattan
manhattan(flk, chr = "chr", bp = "pos", 
          p = "pvalue", snp = "rs",
          col = c("grey10", "grey60"))

#--- hapFLK manhattan
manhattan(hflk, chr = "chr", bp = "pos", 
          p = "hapflk", snp = "rs",
          col = c("grey10", "grey60"), 
          logp=F, type='l', lwd=2)
dev.off()
