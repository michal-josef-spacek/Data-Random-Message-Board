use strict;
use warnings;

use Data::Random::Message::Board;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
is($Data::Random::Message::Board::VERSION, 0.05, 'Version.');
