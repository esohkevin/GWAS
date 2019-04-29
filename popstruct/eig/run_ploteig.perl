#!/usr/bin/perl

#$ENV{'PATH'} = "$HOME/bioTools/EIG-6.1.4/bin:$ENV{'PATH'}";

$command = "ploteig";
$command .= " -i qc-camgwas.evec ";
$command .= " -c 1:2 ";
$command .= " -p ../casecontrol ";
$command .= " -x ";
$command .= " -o qc-camgwas.xtxt "; # must end in .xtxt
print("$command\n");
system("$command");

$command = "evec2pca.perl 10 qc-camgwas.evec qc-camgwas.ind qc-camgwas.pca";
print("$command\n");
system("$command");
