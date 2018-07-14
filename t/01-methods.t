#
#===============================================================================
#
#         FILE: 01-methods.t
#
#  DESCRIPTION:
#
#        FILES: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Sebastian Benque (SWRB), sebastian.benque@gmail.com
# ORGANIZATION:
#      VERSION: 1.0
#      CREATED: 2018-07-06 10:03:57
#     REVISION: ---
#===============================================================================

use strict;
use warnings;

use Test2::Bundle::More;

use API::OpenLibrary::Search;

ok( my $ol = API::OpenLibrary::Search->new, 'Create new instance' );

is( $ol->status_code, undef, 'Does status_code exist' );

is( $ol->search('Die morawische Nacht'), 200, 'Search for book' );
is( $ol->status_code, 200, 'Does status_code return success' );

done_testing();
