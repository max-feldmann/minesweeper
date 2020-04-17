require_relative "tile.rb"

class Grid

    attr_reader :grid, :bomb_count, :grid_size

    def initialize(grid_size)
        # Set up Grid
        @grid = Array.new(grid_size) { Array.new (grid_size)}
        @grid_size = grid_size
        self.populate_grid_with_tiles

        # Maintain Bomb-Stuff
        @bomb_positions = [] #Maintain bomb pos for already_a_bomb
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
        @bomb_count = grid_size - 1 #No. of Bombs is alway 1 less than Grid size

        while bombs_placed < bomb_count
            x = rand(@grid_size)
            y = rand(@grid_size)

            if !already_a_bomb([x,y])
                self[[x,y]].place_bomb
                bombs_placed += 1
                @bomb_positions << [x,y]
            end
        end
    end

    def already_a_bomb(pos)
        @bomb_positions.include?(pos)
    end

    def print_grid #=> displays the grid
        @grid.each_with_index do |row, i|
            display_values = []
            row.each {|tile| display_values << tile.display}
                if i < 10
                    puts "#{i}--#{display_values.join(" ")}"
                else
                    puts "#{i}-#{display_values.join(" ")}"
                end
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
