use strict;
use warnings;

use Data::Random::Message::Board;
use Test::More 'tests' => 3;
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
