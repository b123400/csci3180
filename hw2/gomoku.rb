# CSCI3180 Principles of Programming Languages
# --- Declaration ---
# I declare that the assignment here submitted is original except for source material explicitly acknowledged. I also acknowledge that I am aware of University policy and regulations on honesty in academic work, and of the disciplinary guidelines and procedures applicable to
# breaches of such policy and regulations, as contained in the
# http://www.cuhk.edu.hk/policy/academichonesty/
# Assignment 2 
# Name: 
# Student ID: 
# Email Addr: 

class Gomoku

    def initialize(width=15, height=15)
        @board = self.make_board width, height
    end

    def startGame

        puts "Choose player type for Player O"
        puts "0 = Human, 1 = Computer"

        @player1 = gets.to_i == 1 ? Computer.new(self, "O") : Human.new(self, "O")

        puts "Choose player type for Player X"
        puts "0 = Human, 1 = Computer"

        @player2 = gets.to_i == 1 ? Computer.new(self, "X") : Human.new(self, "X")
        @turn = @player1

        self.startTurn
    end

    def height
        @board.length
    end

    def width
        @board[0].length
    end

    def boardCopy
        @board.map {|a|a.map{|a|a}}
    end

    def make_board(width, height)
        height.times.map {
            width.times.map { "." }
        }
    end

    def printBoard

        x = self.width.times.map  { |i| i }
        y = self.height.times.map { |i| i }

        puts "   " + x
            .map { |i| i < 10 ? " " : (i/10).floor }
            .join(" ")

        puts "   " + x.map { |i| i%10 }.join(" ")

        y.each{ |y|
            puts (y >= 10 ? y.to_s : " "+y.to_s) + " " + @board[y].join(" ")
        }

    end

    def startTurn
        self.printBoard
        move = @turn.nextMove
        puts "Player " + @turn.symbol + " placed at row " + move[0].to_s + " col " + move[1].to_s
        @board[move[1]][move[0]] = @turn.symbol
        if self.full?
            self.printBoard
            puts "Draw game!"
            return
        end
        if winner = self.winner
            self.printBoard
            puts "Player " + winner + " wins!"
            return
        end
        self.nextTurn
    end

    def nextTurn
        @turn = @turn == @player1 ? @player2 : @player1
        self.startTurn
    end

    def valid?(move)
        move[0] >= 0 && move[0] < self.width &&
        move[1] >= 0 && move[1] < self.height &&
        @board[move[1]][move[0]] == "."
    end

    def full?
        !@board.any?{ |a| a.include? "." }
    end

    def winner
        self.boardWinner @board
    end

    def boardWinner(board)
        board.first_map { |row, y|
            row.find_index.with_index { |cell, x|
                self.isCellWinning board, x, y
            }
            .nil_map { |x| [x, y] }
        }
        .nil_map { |coor| board[coor[1]][coor[0]] }
    end

    def isCellWinning(board, x, y)
        symbol = board[y][x]
        return false if symbol == "."

        # horizontal
        i = x
        while i < self.width - 4 && i < x + 5
            if board[y][i] != symbol
                break
            end
            i += 1
        end
        return true if i == x + 5

        #vertical
        i = y
        while i < self.height - 4 && i < y + 5
            if board[i][x] != symbol
                break
            end
            i += 1
        end
        return true if i == y + 5

        #both

        i = x
        j = y
        while i < self.width - 4 && i < x + 5 && j < self.height - 4 && j < y + 5
            if board[j][i] != symbol
                break
            end
            i += 1
            j += 1
        end
        return true if i == x + 5
    end
end


class Player

    def initialize(board, symbol)
        @board = board
        @symbol = symbol
    end

    def nextMove
        throw "subclass should implement nextMove"
    end

    def symbol
        @symbol
    end

end

class Human < Player
    def nextMove
        puts "Enter your move: (format: 'x y')"
        @board.valid?(move = gets.split.map{ |i| i.to_i }) ?
            move :
            (puts "Invalid move, please enter again."; self.nextMove)
    end
end

class Computer < Player
    def nextMove
        self.winningMove || self.randomMove
    end

    def winningMove
        board = @board.boardCopy
        for x in (0..@board.width-1)
            for y in (0..@board.height-1)
                next if board[y][x] != "."
                board[y][x] = @symbol
                if @board.boardWinner(board) == @symbol
                    return [x, y]
                end

                # bonus, prevent other from winning if possible
                alt_sym = @symbol == "O" ? "X" : "O"
                board[y][x] = alt_sym
                if @board.boardWinner(board) == alt_sym
                    return [x, y]
                end
                board[y][x] = "."
            end
        end
        nil
    end

    def randomMove
        @board.valid?(move = [rand(@board.width), rand(@board.height)]) ?
            move :
            self.randomMove
    end
end

class Array
    def first_map
        returned = nil
        self.find_index.with_index { |obj, i|
            returned = yield obj, i
        }
        returned
    end
end

# Haskell's Maybe Functor map
class Object
    def nil_map
        self.nil? ? nil : (yield self)
    end
end

Gomoku.new.startGame