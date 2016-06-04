# CSCI3180 Principles of Programming Languages
# --- Declaration ---
# I declare that the assignment here submitted is original except for source material explicitly acknowledged. I also acknowledge that I am aware of University policy and regulations on honesty in academic work, and of the disciplinary guidelines and procedures applicable to
# breaches of such policy and regulations, as contained in the
# http://www.cuhk.edu.hk/policy/academichonesty/
# Assignment 3
# Name: 
# Student ID: 
# Email Addr: 

package Human;

use parent 'Player';

sub new {
	# param: symbol: String
	my $class = shift;
	my $self = $class->SUPER::new($_[0]);
	# bless $self, $class;
	# print "i am human: $_[0] / $self\n";
	return $self;
}

sub nextMove {
	print "Player X, make a move (row col):";
	my $input = <STDIN>;
	my ($x, $y) = ($input =~ /(\d+)\s(\d+)/);
	return $x, $y;
}

1;