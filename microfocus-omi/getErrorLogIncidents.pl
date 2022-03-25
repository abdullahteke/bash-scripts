#!/opt/OV/nonOV/perl/a/bin/perl

@incidents = ();

sub getIncidents{

	my @output = `/root/scripts/getErrorLogsFromGrayLog.pl`;
	chomp(@output); # removes newlines

	my $linecounter = 0;    
	my @parts=();
	my @event=();

	foreach my $line(@output){

		if ($linecounter > 0){
			# print $line."\n"; #prints line by line	
			@parts= split /,/,$line;
			$event{"timestamp"}=$parts[0];
			$event{"source"}=$parts[1];
			$event{"_id"}=$parts[2];
			$event{"HostName"}=$parts[3];
			$event{"app"}=$parts[4];
			$event{"Level"}=$parts[5];
			$event{"full_message"}=$parts[6];
			$event{"LoggerName"}=$parts[7];
			$event{"Description"}=$parts[8];
			push(@incidents, \%event);
		}

		$linecounter++;
	}
}

getIncidents();
