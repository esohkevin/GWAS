Running PCA
---

1) Prepare PED file format for EIGENSTRAT CONVERTF

`./predPed.sh` for CHPC `qsub predPed.qsub`

2) Convert PED to EIGENSTRAT formats

`./run_convert.sh`for CHPC `qsub run_convert.qsub`

3) Run EIGENSTRAT (PCA)

`./run_eigenstrat.sh` for CHPC `qsub run_eigenstrat.qsub`

4) Run POPGEN (FST)

`./run_popgenstats.sh` for CHPC `qsub run_popgenstats.qsub`


