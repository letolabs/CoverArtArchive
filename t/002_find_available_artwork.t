use strict;
use warnings;
use Test::Most;
use Test::LWP::UserAgent;
use Net::CoverArtArchive;
use Data::Dumper;

plan;

my $release_id = '76df3287-6cda-33eb-8e9a-044b5e15ffdd';

my $caa = Net::CoverArtArchive->new;

lives_ok( sub {
    my $all_artwork = $caa->find_available_artwork($release_id);
}, 'find_available_artwork lives');

done_testing;
