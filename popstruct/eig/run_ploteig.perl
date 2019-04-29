#!/usr/bin/perl

$ENV{'PATH'} = "/home/esoh/bioTools/EIG-6.1.4/bin:$ENV{'PATH'}";

$command = "perl /home/esoh/bioTools/EIG-6.1.4/bin/ploteig";
$command .= " -i qc-camgwas.pca.evec ";
$command .= " -c 1:2 ";
$command .= " -p casecontrol ";
$command .= " -x ";
$command .= " -o qc-camgwas.plot.xtxt "; # must end in .xtxt
print("$command\n");
system("$command");

$command = "evec2pca.perl 10 qc-camgwas.pca.evec ../CONVERTF/qc-camgwas.ind qc-camgwas.pca";
print("$command\n");
system("$command");
