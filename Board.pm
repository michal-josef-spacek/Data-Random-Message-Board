package Data::Random::Message::Board;

use strict;
use warnings;

use Class::Utils qw(set_params);
use Data::Message::Board;
use Data::Message::Board::Comment;
use Data::Random::Person;
use DateTime;
use English;
use Error::Pure qw(err);
use Mo::utils 0.08 qw(check_isa check_required);
use Random::Day::InThePast;
use Text::Lorem;

our $VERSION = 0.01;

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

	# Start date time.
	$self->{'dt_start'} = DateTime->new(
		'day' => 1,
		'month' => 1,
		'year' => ((localtime)[5] + 1900 - 1),
	);

	# Add id or not.
	$self->{'mode_id'} = 1;

	# Number of logins.
	$self->{'num_comments'} = 3;

	# People list.
	$self->{'people'} = [];

	# Process parameters.
	set_params($self, @params);

	check_required($self, 'dt_start');
	check_isa($self, 'dt_start', 'DateTime');

	$self->{'_random_valid_from'} = Random::Day::InThePast->new(
		'dt_from' => $self->{'dt_start'},
	);

	return $self;
}

sub random {
	my $self = shift;

	my $author;
	if (@{$self->{'people'}}) {
		# TODO Select random people.
	} else {
		$author = $self->{'cb_person'}->($self);
	}

	# Date of message board.
	my $board_dt = $self->_random_date;

	# Generate comments.
	my @comments;
	my $saved_comment_author;
	foreach my $i (1 .. $self->{'num_comments'}) {

		# Comment author.
		my $comment_author;
		if (@{$self->{'people'}}) {
			# TODO Select random people.
		} else {
			if ($i % 2 == 1) {
				if (! $saved_comment_author) {
					$saved_comment_author = $self->{'cb_person'}->($self);
				}
				$comment_author = $saved_comment_author;
			} else {
				$comment_author = $author;
			}
		}

		# Comment object. Only if there is random date.
		my $date = $self->_random_date;
		if (defined $date) {
			push @comments, Data::Message::Board::Comment->new(
				'author' => $comment_author,
				'date' => $date,
				$self->{'mode_id'} ? (
					'id' => $self->{'cb_comment_id'}->($self),
				) : (),
				'message' => $self->{'cb_message'}->($self),
			),
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

sub _random_date {
	my $self = shift;

	if (! defined $self->{'_random_valid_from'}) {
		return;
	}

	my $dt = $self->{'_random_valid_from'}->random;
	$self->{'_random_valid_from'} = eval {
		Random::Day::InThePast->new(
			'dt_from' => $dt,
		);
	};
	if ($EVAL_ERROR) {
		$self->{'_random_valid_from'} = undef;
	}

	return $dt;
}

1;

__END__
