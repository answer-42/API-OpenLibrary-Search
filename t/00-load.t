#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'API::OpenLibrary::Search' ) || print "Bail out!\n";
}

diag( "Testing API::OpenLibrary::Search $API::OpenLibrary::Search::VERSION, Perl $], $^X" );
