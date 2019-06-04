#!/usr/bin/env Rscript

args <- commandArgs(TRUE)
png(args[2], height=300, units="px", type = "cairo")
tbl=read.table(args[1])
barplot(t(as.matrix(tbl)), col=rainbow(6), 
	xlab="Individual #", ylab="Ancestry", border=NA)

#width=500, height=300, units="px"
