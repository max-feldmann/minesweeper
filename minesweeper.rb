require_relative "grid.rb"
require_relative "tile.rb"

class Minesweeper
    attr_reader :grid, :last_guess, :bomb_count, :total_to_be_found

    def initialize
        @grid = nil #Grid.new(grid_size) #dynamic grid
        self.boot_game
        @last_guess = nil #=> Set when user input is parsed (in method parse_pos)

        @total_to_be_found = 0
    end

    def boot_game #=> Ask Game-Size > Initialize Grid > call self.run_game
        system ("clear")
        puts "Hello Dude!"
        puts "Lets play Minesweeper! How big do you want your game to be?"
        grid_size = gets.chomp.to_i

        @total_to_be_found = (grid_size * grid_size) - (grid_size - 1)

        @grid = Grid.new(grid_size)
        @grid.place_bombs
        
        self.run_game
    end

    def run_game 
        self.play_turn        
        until over?
            self.play_turn
        end
    end

    def over?
        lost? || won?
    end

    def play_turn #=> Clear the terminal, print the current grid and ask user for input
        system ("clear")
        @grid.print_grid
        #puts
        #@grid.display_all #=> Helper method for testing. Turn on to always also display a grid with bombs revealed.
        self.ask_user_for_input
    end

    def ask_user_for_input #=> Asks user what he wants to do (flag or reveal). Then asks for a position where he wants to do that.
        puts
        puts "What do you want to do? X for Flagging a Postion and R for Revealing a Position"
        puts "(Positions need to be entered like this: row,column)"
        
        user_input = gets.chomp
        handle_user_input(user_input)
    end

    def handle_user_input(user_input) #=> Do sth with the User Input (e.g. Reveal or Flag as Bomb)
        case user_input
            when "X" #> Flagging
                puts "Where do you want to flag?"
                    pos = parse_pos(gets.chomp)
                    @grid[pos].flag_position
            when "R" #> Revealing
                puts "Where do you want to reveal?"
                    pos = parse_pos(gets.chomp)
                    @grid[pos].reveal_position
            end
    end

    def parse_pos(user_guess) #=> Takes a position entered by the user in the form of "1,1" and makes it into an array (of integers) [1,1]
        pos = user_guess.split(",")
        pos = pos.map {|num| Integer(num)}
        @last_guess = pos
        return pos
    end

    def lost? #=> Checks if the position of @grid at last_guess is a bomb
        if @grid[last_guess].bomb && !@grid[last_guess].flagged
            system ("clear")
            @grid.print_grid
            puts
            puts "That was a bomb, bro :/ You Lost! See you!"
            return true
        end
    end

    def won? #> Compare number of revelead tiles to number of non-bomb tiles that can be found
        alread_revealed = 0
        @grid.grid.each do |row|
            row.each do |tile|
                if tile.revealed
                    alread_revealed += 1
                end
            end
        end
        if alread_revealed == @total_to_be_found
            return true
        end
        false
    end
end

game = Minesweeper.new
