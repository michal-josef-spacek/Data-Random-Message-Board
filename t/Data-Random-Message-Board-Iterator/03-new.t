use strict;
use warnings;

use Data::Random::Message::Board::Iterator;
use English;
use Error::Pure::Utils qw(clean);
use Test::More 'tests' => 3;
use Test::NoWarnings;

# Test.
my $obj = Data::Random::Message::Board::Iterator->new;
isa_ok($obj, 'Data::Random::Message::Board::Iterator');

# Test.
eval {
	Data::Random::Message::Board::Iterator->new(
		'dt_start' => undef,
	);
};
is($EVAL_ERROR, "Parameter 'dt_start' is required.\n",
	"Parameter 'dt_start' is required (undef).");
clean();
