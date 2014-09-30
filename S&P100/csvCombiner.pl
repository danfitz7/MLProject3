#!/usr/bin/perl -w

use strict;
use warnings;
use English;
use Date::Calc qw/Delta_Days/;

my $nCompanies = 100;
my $nDates;

my @tickers;
my @closingsLists;
my @dates;
my $datesRetrieved = 0;
my $companyIndex = 0;
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
		#my @closings;
		$dateIndex=0;
		while(<$fh>){ # loop through lines of file
			if (($lookingForTicker == 1) and (/Stock Quotes for (.*),,,,,,$/)){
				$ticker = $1;
#				 print "Found Stocks for $ticker\n";
				$lookingForTicker = 0
			}else{
				if ($datesRetrieved == 0 && /(\d{4})-(\d{2})-(\d{2})/){
					my $day = Delta_Days(2013,1,1, $1, $2, $3);
					push(@dates, $day);
				}
				
				#^.+,\d*\.?\d*$
				if (/\d{4}-\d{2}-\d{2},\d*\.?\d*,\d*\.?\d*,\d*\.?\d*,\d*\.?\d*,\d*,(\d*\.?\d*)$/){
					my $closing = $1;
#					push(@closingList, $closing);
					$closingsLists[$companyIndex][$dateIndex] = $closing;
					$dateIndex++;
				}
			}
		}
		if ($dateIndex >0 ){
			$nDates = $dateIndex;
			$datesRetrieved=$dateIndex
		}
		
#		print("\tFound $dateIndex -1 dates\n");
		
		push(@tickers, $ticker);
		#push(@closingsLists, @closings);
		$companyIndex++;
				
		close($fh);
	}
	#print("Found $companyIndex -1 companies\n");

closedir($dh);

print "DATES:\n";
#print join("C:\Users\Dan\Documents\CLASSWORK\Machine Learning\MLProject3\S&P100\components\n",@dates);

print("Writing to file...\n");

my $outputFileName = "C:/Users/Dan/Documents/CLASSWORK/Machine Learning/MLProject3/S&P100/COMBINED.csv";
open(my $fh, '>', $outputFileName) or die "Could not open output file $outputFileName";
	print $fh ("Date, ",join(',',@tickers),"\n");
	for ($dateIndex=0; $dateIndex<$nDates;$dateIndex++){
		print $fh (@dates[$dateIndex],", ");
		for ($companyIndex = 0; $companyIndex<$nCompanies; $companyIndex++){
			my $closing = $closingsLists[$companyIndex][$dateIndex];
			#print("$tickers[$companyIndex]: ");
			print $fh (($closing?$closing:"?"),",\t");	
		}
		print $fh "\n";
	}
close($fh);
print "\n...Done\n";