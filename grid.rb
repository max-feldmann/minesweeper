require_relative "tile.rb"

class Grid

    attr_reader :grid, :bomb_count, :grid_size

    def initialize(grid_size)
        @grid = Array.new(grid_size) { Array.new (grid_size)}
        @grid_size = grid_size
        @bomb_count = grid_size - 1
        @bomb_positions = []
        self.populate_grid_with_tiles
    end

    def populate_grid_with_tiles #=> populates the grid with tiles
        @grid.each_with_index do |row, x|
            row.each_with_index do |spot, y|
                position = [x,y]
                self[[x,y]] = Tile.new(position)
            end
        end
    end

    def place_bombs #=> places bomb_count bombs by setting the tile objects to true
        bombs_placed = 0

        while bombs_placed < bomb_count
            x = rand(@grid_size-1)
            y = rand(@grid_size-1)

            if !bomb_checker([x,y])
                self[[x,y]].place_bomb
                bombs_placed += 1
                @bomb_positions << [x,y]
            end
        end
    end

    def bomb_checker(pos)
        @bomb_positions.include?(pos)
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
