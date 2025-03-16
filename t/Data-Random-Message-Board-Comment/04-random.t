use strict;
use warnings;

use Data::Person;
use Data::Random::Message::Board::Comment;
use Data::Random::Message::Board::Iterator;
use DateTime;
use Test::More 'tests' => 6;
use Test::NoWarnings;

# Test.
my $obj = Data::Random::Message::Board::Comment->new;
my $ret = $obj->random;
isa_ok($ret, 'Data::Message::Board::Comment');

# Test.
$obj = Data::Random::Message::Board::Comment->new(
	'mode_id' => 0,
);
$ret = $obj->random;
isa_ok($ret, 'Data::Message::Board::Comment');

# Test.
$obj = Data::Random::Message::Board::Comment->new(
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
isa_ok($ret, 'Data::Message::Board::Comment');

# Test.
$obj = Data::Random::Message::Board::Comment->new(
	'dt_iterator' => Data::Random::Message::Board::Iterator->new(
		'dt_start' => DateTime->now->subtract(days => 1),
	),
);
$ret = $obj->random;
isa_ok($ret, 'Data::Message::Board::Comment');
$ret = $obj->random;
if (! defined $ret) {
	ok(1, 'No random comment');
} else {
	isa_ok($ret, 'Data::Message::Board::Comment');
}
