#!/usr/bin/perl
use integer;


foreach $arg (@ARGV) {
	if ($arg =~ /\=/) {
		@keyval = split(/\=/,$arg);
		if ($keyval[0] =~ /\-file/i) {
			$infile =  $keyval[1];
		}
	}
	elsif (lc($arg) eq "help"){
		print "Here is a list of all arguments for bruteforce.pl";
		print "\t-file=filename and directory";
	}
	else{
		print "Must include file location in the format \-file\=C:/directory/inputfilename"
	}
}

$tableOrig = 0; #variable for table take from input file
@totalTable;#array for whole table

open (FILE, $infile);
while(<FILE>){
	chomp;
	#print "$_\n";
	$tableOrig = $_;
}
close (FILE);

@totalTable = split(//, "$tableOrig");
print "Original:\n";
foreach (@totalTable){
		print "$_\n";
	}

sub solve {
	my $temp;
	foreach $temp(0 .. 35){
		next if $totalTable[$temp];
		my %mask = map {
			$_ / 6 == $temp / 6 ||
			$_ % 6 == $temp % 6 ||
			$_ / 12 == $temp / 12 && $_ % 6 / 2 == $temp % 6 / 2
			? $totalTable[$_] : 0,
			1;
		}0 .. 35;
		solve( $totalTable[$temp] = $_) for grep !$mask{$_}, 1 .. 6;
		return $totalTable[$temp] = 0;
	}
	$temp = 0;
	print "\n";
	print "Solved:\n";
	foreach (@totalTable){
		print "$_\n";
	}
}
solve();