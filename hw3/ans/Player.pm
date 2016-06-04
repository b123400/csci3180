# CSCI3180 Principles of Programming Languages
# --- Declaration ---
# I declare that the assignment here submitted is original except for source material explicitly acknowledged. I also acknowledge that I am aware of University policy and regulations on honesty in academic work, and of the disciplinary guidelines and procedures applicable to
# breaches of such policy and regulations, as contained in the
# http://www.cuhk.edu.hk/policy/academichonesty/
# Assignment 3
# Name: 
# Student ID: 
# Email Addr: 

package Player;

sub new {
	# param: symbol: String
	my $class = shift;
	my $self = {
		symbol => $_[0]
	};
	bless $self, $class;
	return $self;
}

sub nextMove {
	# pass
	return -1, -1;
}

1;