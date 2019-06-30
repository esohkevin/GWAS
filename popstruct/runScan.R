#!/usr/bin/Rscript

library(rehh)

## iHS and cross-Population or whole genome scans

args <- commandArgs(TRUE)

hap <- data2haplohh(hap_file = args[1], map_file = args[2], recode.allele = F, min_perc_geno.hap=100,min_perc_geno.snp=100, haplotype.in.columns=TRUE, chr.name = 11)
wg.res <- scan_hh(hap)
wg.ihs <- ihh2ihs(wg.res)
write.table(wg.ihs$iHS, file="iHSResult.txt", col.names=T, row.names=F, quote=F, sep="\t")
write.table(wg.ihs$frequency.class, file="frqResult.txt", col.names=T, row.names=F, quote=F, sep="\t")

# Manhattan PLot of iHS results
png(args[3], height = 700, width = 640, units = "px", type = "cairo")
layout(matrix(1:2,2,1))
ihsplot(wg.ihs, plot.pval = TRUE, ylim.scan = 4, main = args[4])
dev.off()

