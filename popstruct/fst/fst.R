#!/usr/bin/Rscript

require(data.table)

n <- 10

fn <- "cam-1.fst"
all.fst1 <- fread(fn, header = T, data.table = FALSE, nThread = 4)

for (i in 2:10) {
  
  fn <- paste0("cam-",i,".fst")
  all.fst <- fread(fn, header = T, data.table = FALSE, nThread = 4)
  all.fst <- all.fst[,c(3,5)]
  perm.res <- merge(all.fst1, all.fst, by = "POS")
  
}
perm.res <- perm.res[order(perm.res[,c("CHR","POS")]),]
all.fst <- perm.res
all.fst$mean <- rowMeans(all.fst[,c(5:6)])

#head(perm.res)


#all.fst1 <- fread("cam-1.fst", header = T, data.table = FALSE, nThread = 4)
#all.fst2 <- fread("cam-2.fst", header = T, data.table = FALSE, nThread = 4)
#rsids <- all.fst1$SNP
#
#
#all.fst2 <- all.fst2[,c(3,5)]
#head(all.fst)
#all.fst <- merge(all.fst1, all.fst2, by = "POS")
#all.fst <- all.fst[order(all.fst[,c("CHR","POS")]),]

all.fst$mean <- rowMeans(all.fst[,c(5:6)])
#all.fst.sd <- sd(all.fst[,c(5:6)])

#head(all.fst)
#str(all.fst)
png("density.png", height = 16, width = 16, units = "cm", res = 100, points = 14)
plot(density(all.fst$mean))
abline(v=0.005)
dev.off()

