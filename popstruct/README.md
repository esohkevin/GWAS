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
- Get recent ensembl release for human allele frequencies (ftp://ftp.ensembl.org/pub/release-97/variation/vcf/homo_sapiens/)
to ascertain for anc/der allele assignment.
- Extract allele frequencies of variants from QCed dataset
```
vcftools --gzvcf file.vcf.gz --freq --stdout | gzip -c > file.frq.gz
```
Quality control on genotype data: Sample and SNP exclusion criteria
------------
- Genotyping rate < 0.04
- Related individuals based on IBD analysis (PI_HAT > 0.1895)
- Individual missing data rate > 0.10
- Individuals with discordant sex information
- Individuals with outlying ancestry based on eigen-analysis

Data priming
------------
- Extract allele frequencies for IBD analysis with hmmIBD.
- Haplotype estimation (phasing)
- Modeling of recombination map using ldHat
- Ascertainment of ancestral alleles using the 1000 Genomes dataset

Analysis
------------
- Minor allele frequency (MAF) Spectrum
- Linkage disequilibrium (LD) pattern
- Principal Component Analysis: Select ancestry informative markers (LAPSTRUCT)
- Fst Analysis using ancestry informative markers
- Further PCA using ancestry informative markers
- Struturama: Estimate most likely k (number of substructures or clusters)
- Structure: Run with estimated k
- Admixture: Supervised while regressing for ancestry and geography
- Whole genome and cross-population scan for selection signals (iHS-Rsb) with confirmed clusters
- Tajima’s D test to inform directionality of selection signals
