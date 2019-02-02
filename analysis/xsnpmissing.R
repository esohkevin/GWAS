# X chromosome differential missingness
Xdiffmiss=read.table("qc-camgwas-chrX.missing", header = T, as.is = T)
Xdiffmiss=Xdiffmiss[Xdiffmiss$P<0.000001, ]
write.table(Xdiffmiss$SNP, file = "fail-Xdiffmiss.qc", row.names = F, col.names = F, quote = F)
~                                                                                               
