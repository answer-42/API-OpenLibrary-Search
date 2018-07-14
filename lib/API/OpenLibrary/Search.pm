package API::OpenLibrary::Search;

use 5.10.0;

use Moo;
use JSON;
use REST::Client;

=head1 NAME

API::OpenLibrary::Search - The great new API::OpenLibrary::Search!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS
Search the OpenLibrary with their REST API.


    use API::OpenLibrary::Search;

    my $ol = API::OpenLibrary::Search->new();
    $ol->search('Lord of The Rings');

	say $_->{title} for $ol->results;

=head1 Export

None.
=cut

has num_found => ( is => 'rwp' );
has results   => ( is => 'rwp' );

has status_code => ( is => 'rwp' );

=head1 SUBROUTINES/METHODS

=head2 search( $search_term, (search_field) )

=cut

sub search {
    my ( $self, $search_term, $search_field ) = @_;
    $search_field //= 'q';

    my $client = REST::Client->new();
    $client->GET( 'http://openlibrary.org/search.json?'
          . $search_field . '='
          . $search_term );

    my $data = decode_json $client->responseContent;
    my @results;

    foreach my $field ( @{ $data->{docs} } ) {
        push @results, $field;
    }

    $self->_set_results(@results);
    $self->_set_num_found( $data->{num_found} );
    $self->_set_status_code( $client->responseCode );
}

=head2 results()
=cut

=head2 num_found()
=cut

=head2 status_code()
=cut

=head1 AUTHOR

Sebastian Benque, C<< <sebastian.benque at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-api-openlibrary-search at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=API-OpenLibrary-Search>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc API::OpenLibrary::Search


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=API-OpenLibrary-Search>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/API-OpenLibrary-Search>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/API-OpenLibrary-Search>

=item * Search CPAN

L<http://search.cpan.org/dist/API-OpenLibrary-Search/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2018 Sebastian Benque.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see L<http://www.gnu.org/licenses/>.


=cut

1;    # End of API::OpenLibrary::Search
