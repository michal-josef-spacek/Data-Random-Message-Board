use strict;
use warnings;

use Test::NoWarnings;
use Test::Pod::Coverage 'tests' => 2;

# Test.
pod_coverage_ok('Data::Random::Message::Board::Iterator', 'Data::Random::Message::Board::Iterator is covered.');
