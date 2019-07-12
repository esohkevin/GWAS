#!/usr/bin/Rscript

library(rehh)

## iHS and cross-Population or whole genome scans

args <- commandArgs(TRUE)

hapFile <- paste(args[1],".hap", sep="")
mapFile <- paste(args[1],".map", sep="")
chr <- args[2]
iHSplot <- paste(args[3],"iHS.png", sep="")
iHSresult <- paste(args[3],"iHSresult.txt", sep="")
iHSfrq <- paste(args[3],"iHSfrq.txt", sep="")
qqPlot <- paste(args[3],"qqDist.png", sep="")
bifurcA <- paste(args[3],"bifurc1.png", sep="")
bifurcB <- paste(args[3],"bifurc2.png", sep="")
iHSmain <- paste("chr",chr,"-",args[3],"-iHS", sep="")

hap <- data2haplohh(hap_file = hapFile, map_file = mapFile, recode.allele = F, min_perc_geno.hap=100,min_perc_geno.snp=100, haplotype.in.columns=TRUE, chr.name = chr)
wg.res <- scan_hh(hap)
wg.ihs <- ihh2ihs(wg.res)
write.table(wg.ihs$iHS, file = iHSresult, col.names=T, row.names=F, quote=F, sep="\t")
write.table(wg.ihs$frequency.class, file = iHSfrq, col.names=T, row.names=F, quote=F, sep="\t")

# Manhattan PLot of iHS results
png(iHSplot, height = 700, width = 640, res = NA, units = "px")
layout(matrix(1:2,2,1))
ihsplot(wg.ihs, plot.pval = TRUE, ylim.scan = 4, main = iHSmain)
dev.off()

# Gaussian Distribution and Q-Q plots
png(qqPlot, height = 700, width = 440, res = NA, units = "px", type = "cairo")
layout(matrix(1:2,2,1))
distribplot(wg.ihs$iHS[,3], xlab="iHS")
dev.off()

# Bifurcation plot
png(bifurcA, height = 700, width = 640, res = NA, units = "px", type = "cairo")
layout(matrix(1:2,2,1))
bifurcation.diagram(hap,mrk_foc="rs73407039",all_foc=1,nmrk_l=50,nmrk_r=50, refsize = 0.06,
                    main="rs73407039: Ancestral allele")
bifurcation.diagram(hap,mrk_foc="rs73407039",all_foc=2,nmrk_l=50,nmrk_r=50, refsize = 0.06,
                    main="rs73407039: Derived allele")
dev.off()

png(bifurcB, height = 700, width = 640, res = NA, units = "px", type = "cairo")
layout(matrix(1:2,2,1))
bifurcation.diagram(hap,mrk_foc="rs73404549",all_foc=1,nmrk_l=50,nmrk_r=50, refsize = 0.06,
                    main="rs73404549: Ancestral allele")
bifurcation.diagram(hap,mrk_foc="rs73404549",all_foc=2,nmrk_l=50,nmrk_r=50, refsize = 0.06,
                    main="rs73404549: Derived allele")
dev.off()
