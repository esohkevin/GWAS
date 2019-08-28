Population Structure Analysis for CAMGWAS Dataset
---
Workflow
----
- QC
- Eigenstrat outlier removal
- Haplotype estimation (Phasing)
- MAF spectrum
- Fst: Hudson + WC
- LD
- Recombination map - LDHat
- Admixture - admixture, alder, malder
- Structurama/Structure
- fsStructure
- IBD (hmmIBD)/isoRelate
- iHS, EHH, Rsb, XEHH

Design
---
- Get recent ensembl release for [human allele frequencies](ftp://ftp.ensembl.org/pub/release-97/variation/vcf/homo_sapiens/)
to ascertain for anc/der allele assignment.
- Extract allele frequencies of variants from QCed dataset
```
vcftools --gzvcf file.vcf.gz --freq --stdout | gzip -c > file.frq.gz
```
