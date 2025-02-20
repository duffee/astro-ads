package Astro::ADS;

use Moo;

use Carp;
use Data::Dumper;
use Feature::Compat::Try;
use Mojo::Base -strict;
use Mojo::URL;
use Mojo::UserAgent;

no warnings 'experimental'; # suppress warning for native perl 5.36 try/catch

#use constant SESSION_DURATION_SECS => 3600; # 60 min
my $DEBUG = 0;

has ua    => ( is => 'lazy' );
has proxy => ( is => 'lazy' );

has base_url => (
    is      => 'ro',
    default => sub { Mojo::URL->new('https://api.adsabs.harvard.edu/v1/') },
);

sub _build_ua {
    my ($self) = @_;
    return Mojo::UserAgent->new;
}

sub _build_proxy {
    my ($self, $proxy) = @_;
    $self->ua->proxy->https( $proxy );
    return $proxy;
}

sub get_response {
    my ($self, $url) = @_;

    my $tx = $self->ua->build_tx( GET => $url );
    $tx->req->headers->authorization( 'Bearer ' . $ENV{ADS_DEV_KEY} );
    warn $tx->req->to_string if $DEBUG;
   
    try { $tx = $self->ua->start($tx) }
    catch ($error) {
        carp "Got this error: ", $error;
    }

    my $res;
    try { $res = $tx->result } # call to result dies on connection error
    catch ($error) {
        carp "Connection error: ", $error;
        return;
    }
    if    ($res->is_success)  { warn $res->body if $DEBUG > 1 }
    elsif ($res->is_error)    { carp 'HTTP Error: ', $res->message }
    elsif ($res->code == 301) { carp 'Redirected: ', $res->headers->location if $DEBUG }

    return $res;
}

sub post_response {
    my ($self, $url) = @_;

    my $tx = $self->ua->build_tx( POST => $url );
    $tx->req->headers->authorization( 'Bearer ' . $ENV{ADS_DEV_KEY} );
    carp $tx->req->to_string if $DEBUG;
   
    try { $tx = $self->ua->start($tx) }
    catch ($error) {
        carp "Got this error: ", $error;
    }

    return $tx->result;
}

1;

__END__

=head1 NAME

    Astro::ADS

=head1 SYNOPSIS

    my $client = Astro::ADS->new({
        proxy => '...', # your web proxy
    });

    my $search = $client->search( q => 'star', fl => 'bibcode' );

=head1 DESCRIPTION

Astro::ADS is the base class for accessing the Harvard Astrophysical Data Service API.

It handles methods common to all services such as setting the UserAgent and
including your API key in all request headers.

=cut
