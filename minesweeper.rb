require_relative "grid.rb"

class Minesweeper
    attr_reader :grid

    def initialize(grid_size)
        @grid = Grid.new(grid_size) #dynamic grid
        @bombs_placed = 0
    end

    def boot_game #=> Places Bombs
        @grid.place_bombs
    end

    def run #=> Boots the game. Then asks user for input intil game is won.
        self.boot_game

        until lost?
            self.ask_user_for_input
            #won?
        end
    end

    def ask_user_for_input #=> Asks user what he wants to do (flag or reveal). Then asks for a position where he wants to do that.
        system ("clear")
        @grid.print_grid
        
        puts
        puts "What do you want to do? X for Flagging a Postion and R for Revealing a Position"
        puts "(Positions need to be entered like this: row,column)"
            user_input = gets.chomp

            case user_input
                when "X"
                    puts "Where do you want to flag?"
                        pos = parse_pos(gets.chomp)
                        @grid[pos].flag_position
                when "R"
                    puts "Where do you want to reveal?"
                        pos = parse_pos(gets.chomp)
                        @grid[pos].reveal_position
            end
    end

    def parse_pos(user_guess) #=> Takes a position entered by the user in the form of "1,1" and makes it into an array (of integers) [1,1]
        pos = user_guess.split(",")
        pos = pos.map {|num| Integer(num)}
        return pos
    end

    def lost? #=> Will check if user has won and returns true if so.
        return false
    end

end


game = Minesweeper.new(12)
game.run