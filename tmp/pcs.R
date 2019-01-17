par(mfrow=c(1,1))
with(pcs, plot(cov1,cov2, xlim = c(-1,0.2), ylim = c(-0.5,0.5), type = "n", pch=20))
with(subset(pcs,ET=="BA"), points(cov1,cov2, col="black"))
with(subset(pcs,ET=="BM"), points(cov1,cov2, col="red"))
with(subset(pcs,ET=="SBM"), points(cov1,cov2, col="yellow"))
with(subset(pcs,ET=="NC"), points(cov1,cov2, col="blue"))
with(subset(pcs,ET=="FM"), points(cov1,cov2, col="orange"))
with(subset(pcs,ET=="FO"), points(cov1,cov2, col="navy"))
with(subset(pcs,ET=="NA"), points(cov1,cov2, col="white"))
legend(1,1, xjust = 1, yjust = 1, legend = levels(pcs$ET), pch = 16, col = c("black", "red", "yellow", "blue", "orange", "navy", "white"))
#dev.off()


