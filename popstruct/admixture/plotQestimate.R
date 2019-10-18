#!/usr/bin/env Rscript

#setwd("~/esohdata/GWAS/popstruct/admixture/")

args <- commandArgs(TRUE)
fn <- args[1]
#fn <- "adm-data.3.Q"
#fo <- "eth.txt"
outimg <- gsub(".Q",".png",fn)

#--- Load files
tbl=read.table(fn)
n <- ncol(tbl)
fsa <- "../../phase/fs_4.0.1/project/cameig.csv"
qc_eth <- "../world/pca_eth_world_pops.txt"
fsa <- read.csv(fsa, header = T, comment.char = "#")
fsa <- data.table(fsa[,1], fsa[,2], fsa[,3], fsa[,4],
                  fsa[,5], fsa[,6], fsa[,7], fsa[,8], fsa[,9],
                  fsa[,10], fsa[,11], fsa[,12])

colnames(fsa) <- c("FID", "C1", "C2", "C3", "C4", "C5", "C6", 
                   "C7", "C8", "C9", "C10", "Status")
eth <- fread(qc_eth, header = T, col.names = c("FID", "Sex", "ethnicity", "PopGroup"), nThread = 4)
fsaethn <- merge(fsa, eth, by="FID")
fsaethn <- fsaethn[order(ethnicity),]
pcol <- RColorBrewer::brewer.pal(6, "Dark2")
pcol <- rainbow(n)
#sam_names <- read.table(fo, h=F, as.is = T)
#fm <- data.frame(FID=sam_names[,1],
#                 Q1=tbl[,1],
#                 Q2=tbl[,2],
#                 Q3=tbl[,3],
#                 eth=sam_names[,3])

png(outimg, height=18, width=15, units="cm", res=100, type = "cairo")
par(mfrow=c(2,1), mar=c(4,4,1,1))
par(fig=c(0,1,0.60,1))
barplot(t(as.matrix(tbl)), col=c(pcol[1],pcol[2],pcol[3]), 
        ylab="Ancestry", border=NA, space=0,
        main = "Model-based clustering",
        cex.main=0.8)
par(fig=c(0,1,0,0.65), new=T)
plot(fsaethn$C1, fsaethn$C2, xlab="PC1", 
     ylab="PC2", pch = 20, col = "black",
     main="Coancestry by Chromosome Painting",
     cex.main=0.8)
d <- fsaethn[fsaethn$ethnicity=="BA",]
points(d$C1,d$C2, col=pcol[2], pch = 20)
d <- fsaethn[fsaethn$ethnicity=="FO",]
points(d$C1,d$C2, col=pcol[1], pch = 20)
d <- fsaethn[fsaethn$ethnicity=="SB",]
points(d$C1,d$C2, col=pcol[3], pch = 20)
legend("topright", 
       legend=levels(as.factor(fsaethn$ethnicity)),
       col=c(pcol[2],pcol[1],pcol[3]), pch = 20, bty="n", cex = 1)
dev.off()
#width=500, height=300, units="px"

#heatmap(as.matrix(tbl))
#image(as.matrix(tbl))
