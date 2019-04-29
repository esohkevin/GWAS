#!/usr/bin/perl

#$ENV{'PATH'} = "/home/esoh/bioTools/EIG-6.1.4/bin:$ENV{'PATH'}"; 
# MUST put smartpca bin directory in path for smartpca.perl to work

$command = "smartpca.perl";
$command .= " -i ../CONVERTF/qc-camgwas.eigenstratgeno ";
$command .= " -a ../CONVERTF/qc-camgwas.snp ";
$command .= " -b ../CONVERTF/qc-camgwas.ind " ;
$command .= " -k 10 ";
$command .= " -o qc-camgwas.pca ";
$command .= " -p qc-camgwas.plot ";
$command .= " -e qc-camgwas.evec ";
$command .= " -l qc-camgwas-pca.log ";
$command .= " -m 5 ";
$command .= " -t 10 ";
$command .= " -s 6.0 ";
print("$command\n");
system("$command");

$command = "smarteigenstrat.perl "; 
$command .= " -i ../CONVERTF/qc-camgwas.eigenstratgeno ";
$command .= " -a ../CONVERTF/qc-camgwas.snp ";
$command .= " -b ../CONVERTF/qc-camgwas.ind ";
$command .= " -p qc-camgwas-pca ";
$command .= " -k 10 ";
$command .= " -o qc-camgwas.chisq ";
$command .= " -l qc-camgwas-eig.log ";
print("$command\n");
system("$command");

$command = "gc.perl qc-camgwas-chisq qc-camgwas-chisq.GC";
print("$command\n");
system("$command");

$command = "evec2pca.perl 10 qc-camgwas.evec ../CONVERTF/qc-camgwas.ind qc-camgwas.pca";
print("$command\n");
system("$command");

