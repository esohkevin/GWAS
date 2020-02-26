#!/usr/bin/env Rscript

# Prepare alternative individual files with ethnicity status
args <- commandArgs(TRUE)

if (length(args) < 2) {
   print("",quote=F)
   print("Usage: ./prepIndFIle.R [meta_file] [ind_file]",quote=F)
   print("",quote=F)
   print("meta_file: Metadata file containing three columns: sampleIDs Sex Population [e.g. SAM0001 M YRI]",quote=F)
   print(" ind_file: EIGENSTRAT format '.ind' file. NB: Specify path [e.g. CONVERFT/world.ind]",quote=F)
   print("",quote=F)
   quit(save="no")
} else {
   m <- args[1]
   i <- args[2]
   o <- gsub(".ind",".fst.ind",i)
   
   eth <- read.table(m, h=F, as.is=T)
   colnames(eth) <- c("FID","SEX", "ETH")
   eigAnceMapInd <- read.table(i, h=F, as.is=T)
   colnames(eigAnceMapInd) <- c("FID", "SEX", "Status")
   eigAnceMapIndNoStatus <- eigAnceMapInd[,c(1:2)]
   neweth <- merge(eigAnceMapIndNoStatus, eth, by="FID")
   write.table(neweth[,c(1,3:4)], file=o, col.names=F, row.names=F, quote=F)
   
   # With region of sample collection
   #region <- read.table("../merged-data-eth_template.txt", col.names=c("FID", "IID", "REGION"), as.is=T)
   #regionNoIID <- data.frame(FID=region[,1], REGION=region[,3])
   #newregion <- merge(eigAnceMapIndNoStatus, regionNoIID, by="FID")
   #write.table(newregion, file="../CONVERTF/qc-camgwas-reg.ind", col.names=T, row.names=F, quote=F)
}
