use strict;
use warnings;
use Test::Most;
use Test::LWP::UserAgent;
use Net::CoverArtArchive;
use Data::Dumper;

plan;

my $caa = Net::CoverArtArchive->new;

lives_ok( sub {
    my $all_artwork = $caa->find_available_artwork('4331ea73-77e1-3213-a840-5e4e74180f93');
}, 'find_available_artwork lives');

done_testing;
