package WebService::GoogleDirectionAPI;
use strict;
use warnings;

use URI;
use JSON;
use Furl;
use Carp;

use Class::Accessor::Lite (
    new => 1,
    rw  => [qw/mode waypoints alternatives avoid language sensor raw/],
);
# requires: origin destination sensor

our $VERSION = '0.01';

my $url  = 'http://maps.google.com/maps/api/directions/json';
my $json = JSON->new->ascii->utf8(1);
my $furl = Furl->new(timeout => 10);

sub search {
    my ($self, $from, $to) = @_;
    $from ||= '';
    $to   ||= '';
    croak "require value '${from}' -> '${to}'" if !$from || !$to;
    croak "require sensor(true or false)" if ($self->sensor || '') !~ /^true|false$/;

    my $param = $self->_make_param($from, $to);

    my $uri = URI->new($url);
    $uri->query_form($param);
    my $res = $furl->get($uri);

    my $content = $res->content;

    return $self->raw ? $content : $json->decode($content);
}

sub _make_param {
    my ($self, $from, $to) = @_;

    my %param = (
        origin => $from,
	destination => $to,
        sensor => $self->sensor
    );
    $param{mode}         = $self->mode || 'driving';
    $param{waypoints}    = join("|", @{ self->waypoints }) if $self->waypoints && ref($self->waypoints) eq 'ARRAY';
    $param{alternatives} = $self->alternatives if ($self->alternatives || '') =~ /^true|false$/;
    $param{avoid}        = $self->avoid if ($self->avoid || '') =~ /^tolls|highways$/;
    $param{language}     = $self->language if $self->language;

    return \%param;
}

1;
__END__

=head1 NAME

WebService::GoogleDirectionAPI -

=head1 SYNOPSIS

  use WebService::GoogleDirectionAPI;

=head1 DESCRIPTION

WebService::GoogleDirectionAPI is

=head1 AUTHOR

Taiyoh Tanaka E<lt>sun.basix@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
