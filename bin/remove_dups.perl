#!/usr/bin/perl -Tw

use strict;

open (my $myfile, "$ARGV[0]");

my %seen;

while (<$myfile>) {
    chomp;
    my ($c1, $c2) = split(/\t/);
    unless (defined $seen{$c2}) {
        print "$c1\t$c2\n";
        $seen{$c2} = 1;
    }
}

close ($myfile);
