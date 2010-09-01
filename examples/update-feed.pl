#!/usr/bin/env perl
use 5.010;
use strict;
use warnings;
use autodie;

use CPAN::Testers::Metabase::AWS;
use CPAN::Testers::Metabase::Feed;
use DateTime;

my $mb = CPAN::Testers::Metabase::AWS->new(
  bucket => 'cpantesters',
  namespace => 'beta2',
);

my $since = DateTime->now;
$since->subtract( seconds => 300 );

my $feed = CPAN::Testers::Metabase::Feed->new( 
  ct_metabase => $mb,
  since => $since->iso8601
);

my $file = shift( @ARGV ) || die "No filename provided\n";

$feed->save( $file );

