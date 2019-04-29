#!/usr/bin/perl

#$ENV{'PATH'} = "$HOME/bioTools/EIG-6.1.4/bin:$ENV{'PATH'}";

$command = "$HOME/bioTools/EIG-6.1.4/bin/ploteig";
$command .= " -i qc-camgwas.evec ";
$command .= " -c 1:2 ";
$command .= " -p ../casecontrol ";
$command .= " -x ";
$command .= " -o qc-camgwas.xtxt "; # must end in .xtxt
print("$command\n");
system("$command");

