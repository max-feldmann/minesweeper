require_relative "grid.rb"

class Minesweeper
    attr_reader :grid

    def initialize
        @grid = Grid.new
    end

    def boot_game
        @grid.place_bombs
    end

    def run
        self.boot_game

        until self.won?
            system ("clear")
            @grid.print_grid
            self.ask_user_for_input
        end
    end

    def ask_user_for_input
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

    def parse_pos(user_guess)
        pos = user_guess.split(",")
        pos = pos.map {|num| Integer(num)}
        return pos
    end

    def won? #=> Checks if user has won and returns true if so.
        return false
    end

end


game = Minesweeper.new
game.run