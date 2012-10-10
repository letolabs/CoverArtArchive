use strict;
use warnings;
use Test::Most;
use Net::CoverArtArchive;

plan;

# these still hit the live server and need to be mocked
test_instantiate();

sub test_instantiate {
    my $archive = Net::CoverArtArchive->new;
    isa_ok($archive, 'Net::CoverArtArchive');

    my $archive2 = Net::CoverArtArchive->new( id => 'somejunk' );
    isa_ok($archive2, 'Net::CoverArtArchive');

    my $cover_art = Net::CoverArtArchive::CoverArt->new( id => 42 );
    isa_ok($cover_art, 'Net::CoverArtArchive::CoverArt');

    dies_ok( sub {
        Net::CoverArtArchive::CoverArt->new();
    }, 'CoverArt instantiation requires an id' );
}

done_testing;
