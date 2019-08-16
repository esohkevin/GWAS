#!/usr/bin/perl

#$ENV{'PATH'} = "/home/esoh/bioTools/EIG-6.1.4/bin:$ENV{'PATH'}"; 
# MUST put smartpca bin directory in path for smartpca.perl to work

$command = "smartpca.perl";
$command .= " -i ../CONVERTF/con.eigenstratgeno ";
$command .= " -a ../CONVERTF/con.snp ";
$command .= " -b ../CONVERTF/con.ind " ;
$command .= " -k 10 ";
$command .= " -o con.pca ";
$command .= " -p con.plot ";
$command .= " -e con.eval ";
$command .= " -l con-pca.log ";
$command .= " -m 0 ";
$command .= " -t 20 ";
$command .= " -s 7.0 ";
print("$command\n");
system("$command");

$command = "smarteigenstrat.perl "; 
$command .= " -i ../CONVERTF/con.eigenstratgeno ";
$command .= " -a ../CONVERTF/con.snp ";
$command .= " -b ../CONVERTF/con.ind ";
$command .= " -p con.pca ";
$command .= " -k 10 ";
$command .= " -o con.chisq ";
$command .= " -l con-eig.log ";
print("$command\n");
system("$command");

#$command = "gc.perl con.chisq qc-camgwas.chisq.GC";
#print("$command\n");
#system("$command");

#$command = "evec2pca.perl 30 con.pca.evec ../CONVERTF/qc-camgwas.ind qc-camgwas.pca";
#print("$command\n");
#system("$command");

