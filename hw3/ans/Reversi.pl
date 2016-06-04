# CSCI3180 Principles of Programming Languages
# --- Declaration ---
# I declare that the assignment here submitted is original except for source material explicitly acknowledged. I also acknowledge that I am aware of University policy and regulations on honesty in academic work, and of the disciplinary guidelines and procedures applicable to
# breaches of such policy and regulations, as contained in the
# http://www.cuhk.edu.hk/policy/academichonesty/
# Assignment 3
# Name: 
# Student ID: 
# Email Addr: 

package Reversi;

use Computer;
use Human;

sub new {
	my $class = shift;
	my $self = {};
	bless $self, $class;
	$self{'black'} = promptPlayer("X");
	$self{'white'} = promptPlayer("O");
	$self{'turn'} = 1;
	$self{'passCount'} = 0;
	$self->makeBoard();
	return $self;
}

sub makeBoard {
	my $self = shift;
	$self{'board'} = [];
	for my $i (0..7) {
		for my $j (0..7) {
			$self{'board'}[$i][$j] = 0;
			# 0 = empty
			# 1 = player 1
			# 2 = player 2
		}
	}
	$self{'board'}[3][4] = 1;
	$self{'board'}[4][3] = 1;
	$self{'board'}[3][3] = 2;
	$self{'board'}[4][4] = 2;
}

sub promptPlayer {
	# param: symbol: string
	my $symbol = $_[0];
	print "Player $symbol, ";
	print "Are you (1) computer or (2) human? Please enter 1 or 2: ";
	my $input = <STDIN>;
	if ($input == 1) {
		print "Player $symbol is Computer\n";
		return Computer->new($symbol);
	}
	print "Player $symbol is Human\n";
	return Human->new($symbol);
}

sub startGame {
	my $self = shift;
	
	$self->printBoard;
	$self->printStat("X");
	$self->printStat("O");

	my $currentPlayer;
	if ($self{'turn'} == 1) {
		$currentPlayer = $self{'black'};
	} else {
		$currentPlayer = $self{'white'};
	}
	my ($x, $y) = $currentPlayer->nextMove($self);
	my @coorToFlip = $self->isValid($x, $y, $self{'turn'});
	if (0+@coorToFlip) {
		print "Player $currentPlayer->{'symbol'} places to row $y, col $x\n";

		$self{'board'}[$y][$x] = $self{'turn'};
		$self->flip(@coorToFlip);
		$self{'passCount'} = 0;

	} else {
		print "Row $y, col $x is invalid! Player $currentPlayer->{'symbol'} passed!\n";
		$self{'passCount'} = $self{'passCount'} + 1;
	}

	if ($self{'turn'} == 1) {
		$self{'turn'} = 2;
	} else {
		$self{'turn'} = 1;
	}

	my $xCount = $self->countPlayer("X");
	my $oCount = $self->countPlayer("O");

	if ($self{'passCount'} >= 2 || $xCount + $oCount == 64) {

		$self->printBoard;
		$self->printStat("X");
		$self->printStat("O");

		if ($xCount == $oCount) {
			print "Draw game!\n";
		} elsif ($xCount > $oCount) {
			print "Player X wins!\n";
		} else {
			print "Player O wins!\n";
		}
		return;
	}
	# I love recursion
	$self->startGame;
}

sub isValid {
	my $self = shift;
	my $board = $self{'board'};
	my ($x, $y, $turn) = @_;
	if ($x < 0 || $x > 7 || $y < 0 || $y > 7) {
		return ();
	}
	if ($self{'board'}[$y][$x] != 0) {
		return ();
	}
	my @arr = $self->toFlip($x, $y, $turn);
	return @arr;
}

sub toFlip {
	my $self = shift;
	my ($x, $y, $turn) = @_;
	my $i, $j;
	my @coor = ();
	my @temp = ();

	# up
	$i = $x;
	$j = $y - 1;
	while ($j >= 0) {
		if ($self{'board'}[$j][$i] == 0) {
			$j = -1;
			last;
		} elsif ($self{'board'}[$j][$i] != $turn) {
			# opponents
			push(@temp, ($i, $j));
		} else {
			last;
		}
		$j--;
	}
	if ($j < 0) {
		@temp = ();
	}
	push(@coor, @temp);

	# down
	@temp = ();
	$i = $x;
	$j = $y + 1;
	while ($j <= 7) {
		if ($self{'board'}[$j][$i] == 0) {
			$j = 8;
			last;
		} elsif ($self{'board'}[$j][$i] != $turn) {
			# opponents
			push(@temp, ($i, $j));
		} else {
			last;
		}
		$j++;
	}
	if ($j > 7) {
		@temp = ();
	}
	push(@coor, @temp);

	# right
	@temp = ();
	$i = $x+1;
	$j = $y;
	while ($i <= 7) {
		if ($self{'board'}[$j][$i] == 0) {
			$i = 8;
			last;
		} elsif ($self{'board'}[$j][$i] != $turn) {
			# opponents
			push(@temp, ($i, $j));
		} else {
			last;
		}
		$i++;
	}
	if ($i > 7) {
		@temp = ();
	}
	push(@coor, @temp);

	# left
	@temp = ();
	$i = $x-1;
	$j = $y;
	while ($i >= 0) {
		if ($self{'board'}[$j][$i] == 0) {
			$i = -1;
			last;
		} elsif ($self{'board'}[$j][$i] != $turn) {
			# opponents
			push(@temp, ($i, $j));
		} else {
			last;
		}
		$i--;
	}
	if ($i < 0) {
		@temp = ();
	}
	push(@coor, @temp);
	
	# top-left
	@temp = ();
	$i = $x-1;
	$j = $y-1;
	while ($i >= 0 && j >= 0) {
		if ($self{'board'}[$j][$i] == 0) {
			$i = -1;
			$j = -1;
			last;
		} elsif ($self{'board'}[$j][$i] != $turn) {
			# opponents
			push(@temp, ($i, $j));
		} else {
			last;
		}
		$i--;
		$j--;
	}
	if ($i < 0 || $j < 0) {
		@temp = ();
	}
	push(@coor, @temp);

	# bottom-right
	@temp = ();
	$i = $x+1;
	$j = $y+1;
	while ($i <= 7 && j <= 7) {
		if ($self{'board'}[$j][$i] == 0) {
			$i = 8;
			$j = 8;
			last;
		} elsif ($self{'board'}[$j][$i] != $turn) {
			# opponents
			push(@temp, ($i, $j));
		} else {
			last;
		}
		$i++;
		$j++;
	}
	if ($i > 7 || $j > 7) {
		@temp = ();
	}
	push(@coor, @temp);

	# top-right
	@temp = ();
	$i = $x+1;
	$j = $y-1;
	while ($i <= 7 && j >= 0) {
		if ($self{'board'}[$j][$i] == 0) {
			$i = 8;
			$j = -1;
			last;
		} elsif ($self{'board'}[$j][$i] != $turn) {
			# opponents
			push(@temp, ($i, $j));
		} else {
			last;
		}
		$i++;
		$j--;
	}
	if ($i > 7 || $j < 0) {
		@temp = ();
	}
	push(@coor, @temp);

	# bottom-left
	@temp = ();
	$i = $x-1;
	$j = $y+1;
	while ($i >= 0 && j <= 7) {
		if ($self{'board'}[$j][$i] == 0) {
			$i = -1;
			$j = 8;
			last;
		} elsif ($self{'board'}[$j][$i] != $turn) {
			# opponents
			push(@temp, ($i, $j));
		} else {
			last;
		}
		$i--;
		$j++;
	}
	if ($i < 0 || $j > 7) {
		@temp = ();
	}
	push(@coor, @temp);

	return @coor;
}

sub flip {
	my $self = shift;
	my @coor = @_;
	while (0+@coor) {
		my $x = shift @coor;
		my $y = shift @coor;
		$self{'board'}[$y][$x] = $self{'turn'};
	}
}

sub printBoard {
	my $self = shift;
	print "  0 1 2 3 4 5 6 7\n";
	for my $i (0..7) {
		print "$i ";
		for my $j (0..7) {
			if ($self{'board'}[$i][$j] == 0) {
				print ".";
			} elsif ($self{'board'}[$i][$j] == 1) {
				print "X";
			} else {
				print "O";
			}
			print " ";
		}
		print "\n";
	}
}

sub printStat {
	my $self = shift;
	my $symbol = shift;
	my $count = $self->countPlayer($symbol);
	print "Player $symbol: $count\n";
}

sub countPlayer {
	my $self = shift;
	my $symbol = shift;
	my $num = 0;
	my $count = 0;
	if ($symbol eq "X") {
		$num = 1;
	} else {
		$num = 2;
	}
	for my $i (0..7) {
		for my $j (0..7) {
			if ($self{'board'}[$i][$j] == $num) {
				$count++;
			}
		}
	} 
	return $count;
}

sub possibleMoves {
	my $self = shift;
	my @coor = ();
	for my $i (0..7) {
		for my $j (0..7) {
			if ($self->isValid($i, $j, $self{'turn'})) {
				push @coor, ($i, $j)
			}
		}
	}
	return @coor;
}

package Main;

my $game = Reversi->new();
$game->startGame;