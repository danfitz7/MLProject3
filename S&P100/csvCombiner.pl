#!/usr/bin/perl -w

use strict;
use warnings;
use English;

my $nFiles = 100;
my $nDates = 231;

my @tickers;
my @closingsLists;
my $fileIndex = 0;
my $dateIndex = 0;
		
my $path = "C:/Users/Dan/Documents/CLASSWORK/Machine Learning/MLProject3/S&P100/components";
opendir(my $dh, $path) or die "Cannot open dir $path";
	print("Opened directory $path\n");
	my @docs = grep(/\.csv$/,readdir($dh));
	foreach my $file (@docs){ #loop through fies in directory
		#print "Opening doc $file\n";
		my $fh;
		open($fh, "$path/$file") or die "Could not open file $file\n";
		
		#flags and vars
		my $lookingForTicker=1;
		my $ticker;
		my @closings;

		while(<$fh>){ # loop through lines of file
			
			if (($lookingForTicker == 1) and (/Stock Quotes for (.*),,,,,,$/)){
				$ticker = $1;
				print "Found Stocks for $ticker\n";
				$lookingForTicker = 0
			}else{
				#^.+,\d*\.?\d*$
				if (/\d{4}-\d{2}-\d{2},\d*\.?\d*,\d*\.?\d*,\d*\.?\d*,\d*\.?\d*,\d*,(\d*\.?\d*)$/){
					my $closing = $1;
					#push(@closingList, $closing);
					$closingsLists[$fileIndex][$dateIndex] = $closing;
				}
			}
			$dateIndex +=1;
		}
		
		push(@tickers, $ticker);
		push(@closingsLists, @closings);
		$fileIndex +=1;
				
		close($fh);
	}
	

closedir($dh);

print("\n\n\n\n\n");
print(join(',',@tickers));
print("\n");

print "TOTAL DATES: $totDates\n";
for ($dateIndex=0; datei<totDates;datei++){
	for (my $fileIndex = 0; $fileIndex<$totFiles; $fileIndex++){
		print($closingList[$fileIndex][$dateIndex]+",");
	}
	print "\n";
}