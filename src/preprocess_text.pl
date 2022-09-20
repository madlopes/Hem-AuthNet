#!/usr/bin/perl

use strict;

if ($ARGV[0] eq "") {
	print "\n======================================================================================================\n";
	print "Missing Arguments !\n\n";
	print "Usage: preprocess_text.pl <abstracts_file>\n";
	print "======================================================================================================\n";

	exit;
}

open TEXT, "<".$ARGV[0];

while (my $row = <TEXT>) {
	chomp $row;

	$row = lc($row);	
	$row =~ s/inhibitors/inhibitor/g;
	$row =~ s/inhibitory/inhibitor/g;
	$row =~ s/inhibitor//g;
	$row =~ s/coagulation//g;

	$row =~ s/immunogenicity/immune/g;
	$row =~ s/antibodies/antibody/g;

	$row =~ s/mutations/mutation/g;
	$row =~ s/platelets/platelet/g;

	$row =~ s/cells/cell/g;

	$row =~ s/patients//g;
	$row =~ s/patient//g;
	$row =~ s/factor//g;

	$row =~ s/fviii//g;
	$row =~ s/fviiia//g;
	$row =~ s/haemophilia//g;
	$row =~ s/hemophilia//g;
	$row =~ s/viii//g;
	$row =~ s/fix//g;
	$row =~ s/f.ix//g;
	$row =~ s/fixa//g;

	print $row."\n";
}






















