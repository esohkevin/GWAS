###### finding SNPs with pvalue < 0.0001 and preparing for CAVIAR
#run hapflk with '--eigen' flag to perform eigen decomposition
#’.flk’ and ‘.flk.eig’ files are needed for preparing for CAVIAR

file.name <- c("PREFIX") #prefix for output files from hapFLK

flk <- read.table(file=paste(file.name,'.flk',sep=''), h=T)
flk <- subset(flk, !pzero > 0.95)
flk <- subset(flk, !pzero < 0.05)
flk$zscore <- abs(qnorm(flk$pvalue))
flk <- flk[order(flk$pvalue), ]
flk.i <- subset(flk, pvalue <= 0.0001)
if (length(flk.i$rs)>=10) {
   flk <- flk.i} else {
   flk <- head(flk, n=10)
}
keep <- c("rs","zscore")
zscore <- flk[keep]

write.table(zscore,row.names = FALSE, col.names = FALSE, quote = FALSE, file=paste(file.name,'.z',sep=''), sep=" ")

flk.eig=read.table(file=paste(file.name,'.flk.eig',sep=''),head=T)

eig <- merge(flk, flk.eig)
eig <- eig[order(eig$pvalue), ]

eig$rs <- NULL
eig$chr <- NULL
eig$pos <- NULL
eig$pzero <- NULL
eig$flk <- NULL
eig$pvalue <- NULL
eig$zscore <- NULL

mat.eig=as.matrix(eig)
cormat=cor(t(mat.eig))
write.table(cormat,row.names = FALSE, col.names = FALSE, quote = FALSE, file=paste(file.name,'_eig.cor',sep=''), sep=" ")