#!/usr/bin/perl
use strict;
use warnings;

use Getopt::Long;

my $STATE_OK        = 0;
my $STATE_WARNING   = 1;
my $STATE_CRITICAL  = 2;
my $STATE_UNKNOWN   = 3;
my $STATE_DEPENDENT = 4;

sub usage {
    print "usage: check_psgi_cpu.pl -w <percent> -c <percent>\n\n";
    print "options:\n";
    print "  -w, --warning=<INTEGER>\n";
    print "  -c, --critical=<INTEGER>\n";
    exit $STATE_UNKNOWN;
}

my $opt = sub {
    my %opt;
    my @options = (\%opt, qw/help warning=i critical=i/);
    GetOptions(@options) or usage();
    \%opt;
}->();
my $warn = $opt->{warning};
my $crit = $opt->{critical};
usage() unless defined $warn && defined $crit;

my $used = `ps auxw|grep starman|grep psgi|awk '{print \$3}'|sort -r|head -n1`;
chomp $used;

if ($used > $crit) {
    print "crit: $used% > $crit%";
    exit $STATE_CRITICAL;
}

if ($used > $warn) {
    print "warn: $used% > $warn%";
    exit $STATE_WARNING;
}

print "max CPU used $used%";
exit $STATE_OK;
