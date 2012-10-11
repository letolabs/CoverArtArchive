use strict;
use warnings;
use Test::Most;
use Test::LWP::UserAgent;
use Net::CoverArtArchive;
use File::Spec::Functions;

plan;

my $release_id = '76df3287-6cda-33eb-8e9a-044b5e15ffdd';
my $json_file  = catfile((qw/t data/,"$release_id.json"));
my $json;

do {
    $/ = undef;
    open(my $fh, "<", $json_file);
    $json = <$fh>;
};

Test::LWP::UserAgent->map_response( qr{coverartarchive.org/release/$release_id},
    HTTP::Response->new(200, 'OK', ['Content-Type' => 'application/json'], $json)
);

my $caa = Net::CoverArtArchive->new;

my $all_artwork;

lives_ok( sub {
    $all_artwork = $caa->find_available_artwork($release_id);
}, 'find_available_artwork lives');

ok(@$all_artwork, 'got back some artwork');

done_testing;
