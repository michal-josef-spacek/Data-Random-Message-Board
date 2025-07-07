package Data::Random::Message::Board::Comment;

use strict;
use warnings;

use Class::Utils qw(set_params);
use Data::Message::Board::Comment;
use Data::Random::Message::Board::Iterator;
use Data::Random::Person;
use Data::Random::Utils 0.03 qw(item_from_list);
use DateTime;
use Mo::utils 0.21 qw(check_array_object check_isa check_required);
use Text::Lorem;

our $VERSION = 0.07;

sub new {
	my ($class, @params) = @_;

	# Create object.
	my $self = bless {}, $class;

	# Id.
	$self->{'id'} = 1;
	$self->{'cb_id'} = sub {
		return $self->{'id'}++;
	};

	# Callback to message generator.
	$self->{'cb_message'} = sub {
		return join ' ', Text::Lorem->new->sentences(5);
	};

	# Callback to person generator.
	$self->{'cb_person'} = sub {
		return (Data::Random::Person->new(
			'num_people' => 1,
		)->random)[0];
	};

	# Datetime iterator.
	$self->{'dt_iterator'} = Data::Random::Message::Board::Iterator->new(
		'dt_start' => DateTime->new(
			'day' => 1,
			'month' => 1,
			'year' => ((localtime)[5] + 1900 - 1),
		),
	);

	# Add id or not.
	$self->{'mode_id'} = 1;

	# People list.
	$self->{'people'} = [];

	# Process parameters.
	set_params($self, @params);

	check_required($self, 'dt_iterator');
	check_isa($self, 'dt_iterator', 'Data::Random::Message::Board::Iterator');
	check_array_object($self, 'people', 'Data::Person', 'People');

	return $self;
}

sub random {
	my $self = shift;

	# Random date of comment.
	my $date = $self->{'dt_iterator'}->iterate;

	# When run again and again random() date could be undef.
	if (! defined $date) {
		return;
	}

	# Comment author.
	my $comment_author;
	if (@{$self->{'people'}}) {
		item_from_list($self->{'people'}, \$comment_author);
	} else {
		$comment_author = $self->{'cb_person'}->($self);
	}

	# Comment object. Only if there is random date.
	my $comment = Data::Message::Board::Comment->new(
		'author' => $comment_author,
		'date' => $date,
		$self->{'mode_id'} ? (
			'id' => $self->{'cb_id'}->($self),
		) : (),
		'message' => $self->{'cb_message'}->($self),
	);

	return $comment;
}

1;

__END__
