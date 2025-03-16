use strict;
use warnings;

use Data::Random::Message::Board::Iterator;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
is($Data::Random::Message::Board::Iterator::VERSION, 0.03, 'Version.');
