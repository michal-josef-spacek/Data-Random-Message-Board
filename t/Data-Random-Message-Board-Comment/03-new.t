use strict;
use warnings;

use Data::Random::Message::Board::Comment;
use English;
use Error::Pure::Utils qw(clean);
use Test::More 'tests' => 3;
use Test::NoWarnings;

# Test.
my $obj = Data::Random::Message::Board::Comment->new;
isa_ok($obj, 'Data::Random::Message::Board::Comment');

# Test.
eval {
	Data::Random::Message::Board::Comment->new(
		'people' => ['bad'],
	);
};
is($EVAL_ERROR, "Parameter 'people' with array must contain 'Data::Person' objects.\n",
	"Parameter 'people' with array must contain 'Data::Person' objects (bad string).");
clean();
