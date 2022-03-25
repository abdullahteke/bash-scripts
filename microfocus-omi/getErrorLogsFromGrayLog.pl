#!/usr/bin/perl
use strict;
use warnings;
use LWP::UserAgent;
use HTTP::Cookies;
use POSIX qw(strftime);
use JSON::XS;

my $now = time();
my $before = $now - (5*60);      # 5 minutes ago

my $d1=strftime "%Y-%m-%d %H:%M:%S", localtime($now);
my $d2=strftime "%Y-%m-%d %H:%M:%S", localtime($before);

my $fields="timestamp,source,_id,HostName,app,Level,full_message,LoggerName,Description";
print($d1);
print($d2);

my $url = URI->new('http://10.10.10.10:9000/api/search/universal/absolute');
$url->query_form( 'query' => 'Level:ERROR', 'from' => $d2, 'to' => $d1, 'fields'=>$fields);

my $ua = LWP::UserAgent->new;
my $req = HTTP::Request->new('GET' => $url);
$req->authorization_basic('mesk_izleme', '1qaz@wsx3EDC');

my $resp=$ua->request($req);
print $resp->content;
