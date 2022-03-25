#!/opt/OV/nonOV/perl/a/bin/perl

@metrics = ();

sub getMetrics{
		
	my %metric = ();
       	$label = ` snmpget -c community -v 2c 10.133.128.65 1.3.6.1.2.1.47.1.1.1.1.7.9`;
       	$val = ` snmpget -c community -v 2c 10.133.128.65 .1.3.6.1.2.1.99.1.1.1.4.9 `;

       	@tmp = split (":", $label);	
       	$metricName = $tmp[3];
	$metricName =~ s/\n//g;
	$metricName =~ s/"//g;
	print "$metricName\n";

	@tmp2 = split (":", $val);
        $value = @tmp2[3];
	$value =~ s/\n//g;
	$value =~ s/"//g;
	print "$value \n";

	$metric{"time_measured"}= "`date +%s`";
	$metric{"domain"} = "PaloAlto";
	$metric{"node"} = "10.10.10.10";
	$metric{"name"} = "temperaturePaloAlto";
	$metric{"value"} = "$value";
	$metric{"class"} = "node:10.10.10.10";
	$metric{"ci_hint"} = "node:10.10.10.10";
	print "$metric{'name'}\n";
	push(@metrics, \%metric);
	
}

getMetrics();
