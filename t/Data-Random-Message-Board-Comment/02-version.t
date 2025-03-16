use strict;
use warnings;

use Data::Random::Message::Board::Comment;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
is($Data::Random::Message::Board::Comment::VERSION, 0.04, 'Version.');
