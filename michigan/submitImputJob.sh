#!/bin/bash

curl \
	-H "X-Auth-Token: eyJjdHkiOiJ0ZXh0XC9wbGFpbiIsImFsZyI6IkhTMjU2In0.eyJtYWlsIjoia2V2aW4uZXNvaEBzdHVkZW50cy5qa3VhdC5hYy5rZSIsImV4cGlyZSI6MTU0OTE0MDQ0ODg3NiwibmFtZSI6IkVzb2ggS3VtIEtldmluIiwiYXBpIjp0cnVlLCJ1c2VybmFtZSI6ImVzb2hrZXYifQ._3lagRWAS1cO5foAruzU4VW_LEGWagWCTA5uuPEMHo4" \
	-F "input-files-upload=@/BIODATA/StudentsHome/kevine/GWAS/Git/GWAS/michigan/qc-camgwas-updated-chr1.vcf.gz" \
	-F "input-files-upload=@/BIODATA/StudentsHome/kevine/GWAS/Git/GWAS/michigan/qc-camgwas-updated-chr2.vcf.gz" \
        -F "input-files-upload=@/BIODATA/StudentsHome/kevine/GWAS/Git/GWAS/michigan/qc-camgwas-updated-chr3.vcf.gz" \
        -F "input-files-upload=@/BIODATA/StudentsHome/kevine/GWAS/Git/GWAS/michigan/qc-camgwas-updated-chr4.vcf.gz" \
        -F "input-files-upload=@/BIODATA/StudentsHome/kevine/GWAS/Git/GWAS/michigan/qc-camgwas-updated-chr5.vcf.gz" \
        -F "input-files-upload=@/BIODATA/StudentsHome/kevine/GWAS/Git/GWAS/michigan/qc-camgwas-updated-chr6.vcf.gz" \
        -F "input-files-upload=@/BIODATA/StudentsHome/kevine/GWAS/Git/GWAS/michigan/qc-camgwas-updated-chr7.vcf.gz" \
        -F "input-files-upload=@/BIODATA/StudentsHome/kevine/GWAS/Git/GWAS/michigan/qc-camgwas-updated-chr8.vcf.gz" \
        -F "input-files-upload=@/BIODATA/StudentsHome/kevine/GWAS/Git/GWAS/michigan/qc-camgwas-updated-chr9.vcf.gz" \
        -F "input-files-upload=@/BIODATA/StudentsHome/kevine/GWAS/Git/GWAS/michigan/qc-camgwas-updated-chr10.vcf.gz" \
        -F "input-files-upload=@/BIODATA/StudentsHome/kevine/GWAS/Git/GWAS/michigan/qc-camgwas-updated-chr11.vcf.gz" \
        -F "input-files-upload=@/BIODATA/StudentsHome/kevine/GWAS/Git/GWAS/michigan/qc-camgwas-updated-chr12.vcf.gz" \
        -F "input-files-upload=@/BIODATA/StudentsHome/kevine/GWAS/Git/GWAS/michigan/qc-camgwas-updated-chr13.vcf.gz" \
        -F "input-files-upload=@/BIODATA/StudentsHome/kevine/GWAS/Git/GWAS/michigan/qc-camgwas-updated-chr14.vcf.gz" \
        -F "input-files-upload=@/BIODATA/StudentsHome/kevine/GWAS/Git/GWAS/michigan/qc-camgwas-updated-chr15.vcf.gz" \
        -F "input-files-upload=@/BIODATA/StudentsHome/kevine/GWAS/Git/GWAS/michigan/qc-camgwas-updated-chr16.vcf.gz" \
        -F "input-files-upload=@/BIODATA/StudentsHome/kevine/GWAS/Git/GWAS/michigan/qc-camgwas-updated-chr17.vcf.gz" \
        -F "input-files-upload=@/BIODATA/StudentsHome/kevine/GWAS/Git/GWAS/michigan/qc-camgwas-updated-chr18.vcf.gz" \
        -F "input-files-upload=@/BIODATA/StudentsHome/kevine/GWAS/Git/GWAS/michigan/qc-camgwas-updated-chr19.vcf.gz" \
        -F "input-files-upload=@/BIODATA/StudentsHome/kevine/GWAS/Git/GWAS/michigan/qc-camgwas-updated-chr20.vcf.gz" \
        -F "input-files-upload=@/BIODATA/StudentsHome/kevine/GWAS/Git/GWAS/michigan/qc-camgwas-updated-chr21.vcf.gz" \
        -F "input-files-upload=@/BIODATA/StudentsHome/kevine/GWAS/Git/GWAS/michigan/qc-camgwas-updated-chr22.vcf.gz" \
	-F "input-refpanel=apps@phase3" \
	-F "input-population=afr" \
	-F "input-phasing=eagle" https://imputationserver.sph.umich.edu/api/v2/jobs/submit/minimac4

