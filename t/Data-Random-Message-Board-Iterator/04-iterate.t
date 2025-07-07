use strict;
use warnings;

use Data::Random::Message::Board::Iterator;
use DateTime;
use Test::More 'tests' => 4;
use Test::NoWarnings;

# Test.
my $obj = Data::Random::Message::Board::Iterator->new(
	'dt_start' => DateTime->now->subtract(days => 10),
);
my $ret1 = $obj->iterate;
isa_ok($ret1, 'DateTime');
my $ret2 = $obj->iterate;
if (! defined $ret2) {
	ok(1, 'No second random date');
} else {
	is(DateTime->compare($ret1, $ret2), -1, 'First random date is older than second.');
}

# Test.
my $today = DateTime->now;
my $yesterday = $today->clone;
$yesterday->subtract(days => 1);
$obj = Data::Random::Message::Board::Iterator->new(
	'dt_start' => $yesterday,
);
my $ret = $obj->iterate;
is($ret->ymd, $today->ymd, 'Returns today YMD.');

