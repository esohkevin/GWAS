#!/usr/bin/Rscript

setwd("~/GWAS/Git/GWAS/popstruct")
library(rehh)

## Tutorial
#make.example.files()
#dir()
#
#map <- read.table("map.inp")
#hap <- data2haplohh(hap_file = "bta12_cgu.hap", map_file = "map.inp", recode.allele = TRUE, chr.name = 12)
#head(haps)
#dim(haps)
#head(map)
#dim(map)
#data("haplohh_cgu_bta12")
#res.ehh <- calc_ehh(haplohh_cgu_bta12, mrk = "F1205400")
#res.ehh$ehh[1:2,454:458]
#res.ehh$nhaplo_eval[1:2,454:458]
#res.ehh$freq_all1
#res.ehh$ihh
#
#res.ehhs <- calc_ehhs(haplohh_cgu_bta12, mrk = "F1205400")
#
#res.scan <- scan_hh(haplohh_cgu_bta12)
#dim(res.scan)
#res.scan[453:459,]
#
## iHHS and iHH
#data("wgscan.cgu")
#ihs.cgu <- ihh2ihs(wgscan.cgu)
#head(ihs.cgu$iHS)
#head(ihs.cgu$frequency.class)
#
## Manhattan plot of iHS results
#layout(matrix(1:2,2,1))
#ihsplot(ihs.cgu,plot.pval = TRUE,ylim.scan = 2,main = "iHS (CGU cattle breed)")
#
### My Data Test
#
## Convert Plink bim file to rehh map file format
#bim <- read.table("chr11.bim", col.names=c("CHR", "RSID", "cM", "BP", "A1", "A2"), as.is=T)
#newBim <- data.frame(bim$RSID, bim$CHR, bim$BP, bim$A2, bim$A1)
#write.table(newBim, file="chr11.map", col.names=F, row.names=F, quote=F, sep = "\t")
#
## Updated transposed haplotype file by switching 1st and 2nd columns
#haps <- read.table("chr11.tped")
#newhaps <- haps[,5:ncol(haps)]
#hapsUpdated <- data.frame(newBim[,1:3], newhaps)
#write.table(hapsUpdated, file = "chr11-updated.haps", col.names = F, row.names = F, quote = F)
#
## Load data set
#hap <- data2haplohh(hap_file = "chr11-updated.haps", map_file = "chr11.map", recode.allele = TRUE, min_perc_geno.hap=100,min_perc_geno.snp=100, haplotype.in.columns=TRUE, chr.name = 11)
#
## Compute EHH
#res.ehh <- calc_ehh(hap, mrk = "rs10742584")
#
## Get statistics
#res.ehh$ehh
#res.ehh$nhaplo_eval
#res.ehh$freq_all1
#res.ehh$ihh
#
## Compute EHHS
#res.ehhs <- calc_ehhs(hap, mrk = "rs10742584")
#res.ehhs$nhaplo_eval
#res.ehhs$EHHS_Tang_et_al_2007
#res.ehhs$IES_Tang_et_al_2007  
#res.ehhs$EHHS_Sabeti_et_al_2007
#res.ehhs$IES_Sabeti_et_al_2007
#
## Scan the entire SNPs
#res.scan <- scan_hh(hap)
#dim(res.scan)

# iHS and cross-Population or whole genome scans
hap <- data2haplohh(hap_file = "chr11All.haps", map_file = "chr11All.map", recode.allele = TRUE, min_perc_geno.hap=100,min_perc_geno.snp=100, haplotype.in.columns=TRUE, chr.name = 11)
wg.res <- scan_hh(hap)
wg.ihs <- ihh2ihs(wg.res)
#head(wg.ihs$iHS)
#head(wg.ihs$frequency.class)
wg.ihs$iHS

