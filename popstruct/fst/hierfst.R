#!/usr/bin/Rscritp

#setwd("~/esohdata/GWAS/popstruct/fst")
#setwd("~/Git/popgen/fst/")

#------- Load packages
require(hierfstat)
require(adegenet)
require(parallel)
require(data.table)
require(pegas)


#------- Read in files
for (i in 1:2) {
  ph <- paste0("perm",i,".txt")
  pheno <- ph
  fpheno <- as.data.frame(fread(pheno, nThread = 4, header = F))
  colnames(fpheno) <- c("FID", "IID", "ETH")
  
  #-------- Load VCF
  f <- paste0("hier-",i,".vcf.gz")
  fn <- "hier-1.vcf.gz"
  x.1 <- VCFloci(fn)
  base <- c("A","T","G","C")
  snps <- which(x.1$REF %in% base & x.1$ALT %in% base)
  x <- read.vcf(fn, which.loci = snps)
  para_dat <- genind2hierfstat(loci2genind(x), pop = fpheno$ETH)
  
  #-------- Initialize Output
  bstat1 <- paste0("bstats",i,".txt")
  bstat2 <- paste0("bstats",i,".Fst")
  hvc <- paste0("hier-",i,".vcomp.loc")
  hvcpng <- paste0("hier-",i,".png")


  #-------- Variance component
  para_vc <-hierfstat::varcomp.glob(data.frame(fpheno$ETH), para_dat[,-c(1)])
  para_vc$F
  fwrite(para_vc$loc, file = hvc, buffMB = 10, nThread = 30, sep = " ")

  #-----------------------------------------------------------------------------#
  #plot(para_vc$loc[,1], para_vc$loc[,2], pch = 16)
  #hist(para_vc$loc[,1])

  png(hvcpng, height = 16, width = 16, units = "cm", res = 100, points = 14)
  plot(density(para_vc$loc[,2]))
  dev.off()
  
  #-------- Compute basic stat
  para_bstat <- basic.stats(na.omit(para_dat))
  print("Ethnicity", quote = FALSE)
  fwrite(para_bstat$overall, file = bstat1, buffMB = 10, nThread = 30, sep = " ")
  
  fwrite(para_bstat$perloc$Fst, file = bstat2, buffMB = 10, nThread = 30, sep = " ")
  
  
  #-------- Test Between levels
  #para_tb <- test.between(alt_dat[,-c(1)], test.lev = fpheno$ALTCAT, 
  #                        rand.unit = fpheno$PARACAT)
  
  #-------- Test significance of the effect of level on differentiation
  #para_g <- test.g(para_dat[,-c(1)], level = fpheno$ETH, nperm = 1000)
  #para_g$p.val

}

#para_boot <- boot.vc(data.frame(fpheno$ETH), para_dat[,-c(1)], nboot = 100)
#para_boot
#-----------------------------------------------------------------------------#

#require(shuffleSet)


#-------- Plot NJ tree
#png("bionj.png", height = 15, width = 15, units = "cm", res = 100, points = 12)
#for (i in c("para_dat")) {
#  if (i == "para_dat") {
#    i.name <- "ETH"
#    i.main <- "Ethnicity"
#    d <- genet.dist(na.omit(para_dat))
#    d <- as.matrix(d)
#    dimnames(d)[[1]] <- dimnames(d)[[2]] <- as.character(levels(para_dat[,1]))
#    my.col <- as.integer(fpheno$i.name)
#    x <- table(fpheno$i.name, my.col)
#    my.col <- apply(x,1, function(y) which(y>0))
#    plot(bionj(d), type = "unrooted", lab4ut = "axial", 
#         cex = 0.8, tip.color = my.col, main = i.main)
#    mtext(paste0("p-value ",para_g$p.val), side = 3)
#    #text(6, 2, paste0("p-value ", para_g$p.val),
#    #     cex = 0.8)
#    
#  }
#}
#dev.off()
#  
#
#png("boxplots.png", height = 13, width = 18, units = "cm", res = 100, points = 14)
#boxplot(para_bstat$perloc[,c(1:3)], main = "Ethnicity")
#mtext(paste0("p-value ",para_g$p.val), side = 3)
#dev.off()
