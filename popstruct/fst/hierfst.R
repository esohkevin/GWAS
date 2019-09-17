#!/usr/bin/Rscritp

setwd("~/esohdata/GWAS/popstruct/fst")
#setwd("~/Git/popgen/fst/")

#------- Load packages
require(hierfstat)
require(adegenet)
require(parallel)
require(data.table)
require(pegas)

#------- Read in files
pheno <- "pheno.txt"
fpheno <- as.data.frame(fread(pheno, nThread = 4))

#-------- Load VCF
fn <- "hier.vcf.gz"
x.1 <- VCFloci(fn)
base <- c("A","T","G","C")
snps <- which(x.1$REF %in% base & x.1$ALT %in% base)
x <- read.vcf(fn, which.loci = snps)
para_dat <- genind2hierfstat(loci2genind(x), pop = fpheno$ETH)


#-------- Compute basic stat
para_bstat <- basic.stats(na.omit(para_dat))
print("Ethnicity", quote = FALSE)
para_bstat$overall

#-------- Test Between levels
#para_tb <- test.between(alt_dat[,-c(1)], test.lev = fpheno$ALTCAT, 
#                        rand.unit = fpheno$PARACAT)

#-------- Test significance of the effect of level on differentiation
para_g <- test.g(para_dat[,-c(1)], level = fpheno$ETH, nperm = 1000)
para_g$p.val


#-------- Plot NJ tree
png("bionj.png", height = 15, width = 15, units = "cm", res = 100, points = 12)
for (i in c("para_dat")) {
  if (i == "para_dat") {
    i.name <- "ETH"
    i.main <- "Ethnicity"
    d <- genet.dist(na.omit(para_dat))
    d <- as.matrix(d)
    dimnames(d)[[1]] <- dimnames(d)[[2]] <- as.character(levels(para_dat[,1]))
    my.col <- as.integer(fpheno$i.name)
    x <- table(fpheno$i.name, my.col)
    my.col <- apply(x,1, function(y) which(y>0))
    plot(bionj(d), type = "unrooted", lab4ut = "axial", 
         cex = 0.8, tip.color = my.col, main = i.main)
    mtext(paste0("p-value ",para_g$p.val), side = 3)
    #text(6, 2, paste0("p-value ", para_g$p.val),
    #     cex = 0.8)
    
  }
}
dev.off()
  

png("boxplots.png", height = 13, width = 18, units = "cm", res = 100, points = 14)
boxplot(para_bstat$perloc[,c(1:3)], main = "Ethnicity")
mtext(paste0("p-value ",para_g$p.val), side = 3)
dev.off()
