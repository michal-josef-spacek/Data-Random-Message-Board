package Data::Random::Message::Board::Iterator;

use strict;
use warnings;

use Class::Utils qw(set_params);
use DateTime;
use English;
use Error::Pure::Utils qw(clean);
use Mo::utils 0.08 qw(check_isa check_required);
use Random::Day::InThePast 0.17;

our $VERSION = 0.05;

sub new {
	my ($class, @params) = @_;

	# Create object.
	my $self = bless {}, $class;

	# Start date time.
	$self->{'dt_start'} = DateTime->new(
		'day' => 1,
		'month' => 1,
		'year' => ((localtime)[5] + 1900 - 1),
	);

	# Process parameters.
	set_params($self, @params);

	check_required($self, 'dt_start');
	check_isa($self, 'dt_start', 'DateTime');

	$self->{'_random_valid_from'} = Random::Day::InThePast->new(
		'dt_from' => $self->{'dt_start'},
	);

	return $self;
}

sub iterate {
	my $self = shift;

	if (! defined $self->{'_random_valid_from'}) {
		return;
	}

	my $dt = $self->{'_random_valid_from'}->random;
	$dt->add('days' => 1);
	$self->{'_random_valid_from'} = eval {
		Random::Day::InThePast->new(
			'dt_from' => $dt,
		);
	};
	if ($EVAL_ERROR) {
		$self->{'_random_valid_from'} = undef;
		clean();
	}

	return $dt;
}

1;

__END__
