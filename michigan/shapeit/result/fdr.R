#!/us/bin/Rscript

args <- commandArgs(TRUE)
#calc_fdr <- function() {
	assoc <- read.table(args[1], header=T, as.is=T)
	P <- assoc$P
	fdr <- p.adjust(as.vector(P), method="BH")
	hits <- fdr[fdr<=0.05]
	print(hits[hits<=0.05])
	#write.table(hits, file=args[2], col.names=TRUE, row.names-FALSE)
#}

#calc_fdr()
