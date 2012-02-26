#!/usr/bin/perl
use strict;
use warnings;

my $STATE_OK        = 0;
my $STATE_WARNING   = 1;
my $STATE_CRITICAL  = 2;
my $STATE_UNKNOWN   = 3;
my $STATE_DEPENDENT = 4;

my $srv = shift;
unless ($srv) {
    print "usage: check_svstat.pl [service]\n";
    exit $STATE_UNKNOWN;
}

my $ofs = {
    proc => 0,
    stat => 1,
    pid  => 3,
    sec  => 4,
};

my $result  = `sudo svstat /service/$srv 2>&1`;
unless ($result =~ /^\/service\/.+ seconds$/) {
    print $result;
    exit $STATE_UNKNOWN;
}
my $res = [split / /, $result];

my $stat = $res->[$ofs->{stat}];
unless ($stat eq 'up') {
    print "$srv is $stat\n";
    exit $STATE_CRITICAL;
}

my $sec = $res->[$ofs->{sec}];
if ($sec < 2) {
    print "$srv up $sec seconds\n";
    exit $STATE_CRITICAL;
}

print "$result";
exit $STATE_OK;
