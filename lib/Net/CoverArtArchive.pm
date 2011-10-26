package Net::CoverArtArchive;
use Moose;

our $VERSION = '1.00';

use List::UtilsBy qw( partition_by nsort_by );
use LWP::UserAgent;
use Net::CoverArtArchive::CoverArt;
use XML::XPath;

has lwp => (
    isa => 'LWP::UserAgent',
    is => 'ro',
    required => 1,
    default => sub {
        my $lwp = LWP::UserAgent->new;
        $lwp->env_proxy;
        return $lwp;
    }
);

sub find_available_artwork {
    my ($self, $release_mbid) = @_;

    my $res = $self->lwp->get('http://s3.amazonaws.com/mbid-' . $release_mbid);
    if ($res->is_success) {
        my $xp = XML::XPath->new( xml => $res->content );
        my @artwork = map {
            my $key = $xp->find('Key', $_);
            Net::CoverArtArchive::CoverArt->new(
                artwork => "http://s3.amazonaws.com/mbid-$release_mbid/" .
                    $key->string_value
            );
        } $xp->find('/ListBucketResult/Contents')->get_nodelist;

        return partition_by { $_->type } nsort_by { $_->page } @artwork
    }
    else {
        return ();
    }
}

1;