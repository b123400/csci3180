# CSCI3180 Principles of Programming Languages
# --- Declaration ---
# I declare that the assignment here submitted is original except for source material explicitly acknowledged. I also acknowledge that I am aware of University policy and regulations on honesty in academic work, and of the disciplinary guidelines and procedures applicable to
# breaches of such policy and regulations, as contained in the
# http://www.cuhk.edu.hk/policy/academichonesty/
# Assignment 3
# Name: 
# Student ID: 
# Email Addr: 

package Computer;

use parent 'Player';

sub new {
	# param: symbol: String
	my $class = shift;
	my $self = $class->SUPER::new($_[0]);
	bless $self, $class;
	return $self;
}

sub nextMove {
	my $self = shift;
	my $game = shift;
	my @moves = $game->possibleMoves;
	if (!@moves) {
		return -1, -1;
	}
	my $index = int(rand((0+@moves)/2));
	my $x = $moves[$index*2];
	my $y = $moves[$index*2+1];

	return $x, $y;
}



1;