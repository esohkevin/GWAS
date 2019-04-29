#!/usr/bin/perl

$command = "twstats";
$command .= " -t ../twtable ";
$command .= " -i qc-camgwas.eval ";
$command .= " -o qc-camgwas-tw.out";
print("$command\n");
system("$command");

