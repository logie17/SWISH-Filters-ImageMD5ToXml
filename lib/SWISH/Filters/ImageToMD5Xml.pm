package SWISH::Filters::ImageToMD5Xml;
use strict;
use warnings;
use base 'SWISH::Filters::Base';
use Digest::MD5 qw(md5);

=head1 NAME

SWISH::Filters::ImageToMD5Xml - Adds MD5 information when filtering an image for SWISHE.

=head1 VERSION

Version 0.02

=cut

our $VERSION = '0.02';


=head1 SYNOPSIS

A SWISHE filter that takes an incoming image XML applies a MD5 checksum
against the binary content of the image.  

=head1 METHODS

=head2 new ( $class )

Constructor. 

=cut

sub new {
    my ( $class ) = @_;

    $class = ref $class || $class;

    my $self = bless { }, $class;

    return $self->_init;
}

sub _init {
    my ( $self ) = @_;

    $self->use_modules(qw/MIME::Base64 Search::Tools::XML XML::Simple/);

    my @mimetypes = (
        'application/xml'
    );

    $self->{mimetypes} = \@mimetypes;

    return $self;
}

sub _parse_xml {
    my ( $self, $xml ) = @_;

    if ( $xml ) {
        return XMLin($xml);
    }
}

=head2 filter( $self, $doc )

Generates XML meta data for indexing.

=cut

sub filter {
    my ( $self, $doc ) = @_;

    return if $doc->is_binary;

    if ( my $xml = $doc->fetch_filename ) {
        if ( my $ds  = $self->_parse_xml($xml) ) {
            my $utils  = Search::Tools::XML->new;
            $ds->{md5}    = md5($ds->{b64_data});
            my $xml = $utils->perl_to_xml($ds, 'image_data', );
            $doc->set_content_type('application/xml');
            return $xml;
        }
    }

    return;
}


=head1 AUTHOR

Logan Bell, C<< <loganbell at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-swish-filters-imagetomd5xml at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=SWISH-Filters-ImageToMD5Xml>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SWISH::Filters::ImageToMD5Xml


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=SWISH-Filters-ImageToMD5Xml>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/SWISH-Filters-ImageToMD5Xml>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/SWISH-Filters-ImageToMD5Xml>

=item * Search CPAN

L<http://search.cpan.org/dist/SWISH-Filters-ImageToMD5Xml/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2011 Logan Bell.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of SWISH::Filters::ImageToMD5Xml
