#!/usr/bin/Rscript

args <- commandArgs(TRUE)
chrlog <- read.table(args[1], header=T, as.is=T)
print(' ', quote=F)
print(args[1], quote=F)
mean(chrlog$PHASE_CONFIDENCE)
sd(chrlog$PHASE_CONFIDENCE)
