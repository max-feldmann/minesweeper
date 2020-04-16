require_relative "tile.rb"

class Grid

    attr_accessor :grid, :bomb_count


    def initialize
        @grid = Array.new(9) { Array.new (9)}
        @bomb_count = 9 #@grid.size + 1 # wenn grid.size dynamisiert wird. Aktuell 9+1 = 10
        self.populate_grid
        self.place_bombs(bomb_count)
        self.print_grid
    end

    def populate_grid #=> populates the grid with tiles
        @grid.each_with_index do |row, x|
            row.each_with_index do |spot, y|
                position = [x,y]
                self[[x,y]] = Tile.new(position)
            end
        end
    end

    def place_bombs(bomb_count) #=> places bomb_count bombs by setting the tile objects to true
        bombs_placed = 0
        while bombs_placed < bomb_count
            x = rand(8)
            y = rand(8)
            self[[x,y]].place_bomb
            bombs_placed += 1
        end

    end

    def print_grid #=> displays the grid
        @grid.each do |row|
            display_values = []
            row.each {|tile| display_values << tile.display}
            puts "#{display_values.join(" ")}"
        end
    end



#---------------HELPER-METHODS----------------

    def [](pos)
        row, col = pos
        @grid[row][col]
    end

    def []=(pos, value)
      row, col = pos
      @grid[row][col] = value
    end

end

g = Grid.new