use strict;
use warnings;

use Data::Person;
use Data::Random::Message::Board;
use DateTime;
use Test::More 'tests' => 6;
use Test::NoWarnings;

# Test.
my $obj = Data::Random::Message::Board->new;
my $ret = $obj->random;
isa_ok($ret, 'Data::Message::Board');

# Test.
$obj = Data::Random::Message::Board->new(
	'mode_id' => 0,
);
$ret = $obj->random;
isa_ok($ret, 'Data::Message::Board');

# Test.
$obj = Data::Random::Message::Board->new(
	'people' => [
		Data::Person->new(
			'name' => 'John Doe',
		),
		Data::Person->new(
			'name' => 'Jan Novak',
		),
	],
);
$ret = $obj->random;
isa_ok($ret, 'Data::Message::Board');

# Test.
$obj = Data::Random::Message::Board->new(
	'dt_start' => DateTime->now->subtract(days => 1),
);
$ret = $obj->random;
isa_ok($ret, 'Data::Message::Board');
$ret = $obj->random;
is($ret, undef, 'No random message board.');
