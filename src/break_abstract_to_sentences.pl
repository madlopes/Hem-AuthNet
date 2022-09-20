#!/usr/bin/perl

use strict;

if ($ARGV[0] eq "") {
	print "\n======================================================================================================\n";
	print "Missing Arguments !\n\n";
	print "Usage: break_abstract_to_sentences.pl <abstracts_file>\n";
	print "======================================================================================================\n";

	exit;
}

open TEXT, "<".$ARGV[0];

while (my $row = <TEXT>) {
	chomp $row;

	$row = lc($row);
	$row =~ s/\. /\.\n/g;
	print $row."\n";
}






















