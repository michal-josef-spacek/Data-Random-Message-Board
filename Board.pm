package Data::Random::Message::Board;

use strict;
use warnings;

use Class::Utils qw(set_params);
use Data::Message::Board;
use Data::Random::Message::Board::Comment;
use Data::Random::Message::Board::Iterator;
use Data::Random::Person;
use Data::Random::Utils 0.03 qw(item_from_list);
use DateTime;
use Mo::utils 0.21 qw(check_array_object check_isa check_required);
use Text::Lorem;

our $VERSION = 0.04;

sub new {
	my ($class, @params) = @_;

	# Create object.
	my $self = bless {}, $class;

	# Comment id.
	$self->{'comment_id'} = 1;
	$self->{'cb_comment_id'} = sub {
		return $self->{'comment_id'}++;
	};

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

	# Number of logins.
	$self->{'num_comments'} = 3;

	# People list.
	$self->{'people'} = [];

	# Process parameters.
	set_params($self, @params);

	check_required($self, 'dt_iterator');
	check_isa($self, 'dt_iterator', 'Data::Random::Message::Board::Iterator');
	check_array_object($self, 'people', 'Data::Person', 'People');

	$self->{'_random_comment'} = Data::Random::Message::Board::Comment->new(
		'cb_id' => $self->{'cb_comment_id'},
		'cb_message' => $self->{'cb_message'},
		'cb_person' => $self->{'cb_person'},
		'dt_iterator' => $self->{'dt_iterator'},
		'id' => $self->{'comment_id'},
		'mode_id' => $self->{'mode_id'},
		'people' => $self->{'people'},
	);

	return $self;
}

sub random {
	my $self = shift;

	# Date of message board.
	my $board_dt = $self->{'dt_iterator'}->iterate;

	# When run again and again random() date could be undef.
	if (! defined $board_dt) {
		return;
	}

	# Message board author.
	my $author;
	if (@{$self->{'people'}}) {
		item_from_list($self->{'people'}, \$author);
	} else {
		$author = $self->{'cb_person'}->($self);
	}

	# Generate message board.
	my @comments;
	foreach my $i (1 .. $self->{'num_comments'}) {
		my $random_comment = $self->{'_random_comment'}->random;
		if (defined $random_comment) {
			push @comments, $random_comment;
		}
	}
	my $message_board = Data::Message::Board->new(
		'author' => $author,
		'comments' => \@comments,
		'date' => $board_dt,
		$self->{'mode_id'} ? (
			'id' => $self->{'cb_id'}->($self),
		) : (),
		'message' => $self->{'cb_message'}->($self),
	);

	return $message_board;
}

1;

__END__
