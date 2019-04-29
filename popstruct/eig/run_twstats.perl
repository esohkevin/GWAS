#!/usr/bin/perl

$command = "/home/esoh/bioTools/EIG-6.1.4/bin/twstats";
$command .= " -t ../twtable ";
$command .= " -i qc-camgwas.eval ";
$command .= " -o qc-camgwas-tw.out";
print("$command\n");
system("$command");

