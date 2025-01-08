use strict;
use warnings;

use Data::Random::Message::Board;
use English;
use Error::Pure::Utils qw(clean);
use Test::More 'tests' => 5;
use Test::NoWarnings;

# Test.
my $obj = Data::Random::Message::Board->new;
isa_ok($obj, 'Data::Random::Message::Board');

# Test.
eval {
	Data::Random::Message::Board->new(
		'dt_start' => undef,
	);
};
is($EVAL_ERROR, "Parameter 'dt_start' is required.\n",
	"Parameter 'dt_start' is required (undef).");
clean();

# Test.
eval {
	Data::Random::Message::Board->new(
		'dt_start' => 'bad',
	);
};
is($EVAL_ERROR, "Parameter 'dt_start' must be a 'DateTime' object.\n",
	"Parameter 'dt_start' must be a 'DateTime' object (bad).");
clean();

# Test.
eval {
	Data::Random::Message::Board->new(
		'people' => ['bad'],
	);
};
is($EVAL_ERROR, "People isn't 'Data::Person' object.\n",
	"People isn't 'Data::Person' object (bad string).");
clean();
