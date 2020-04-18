class Tile

    DIAGIONAL_NEIGHBOURS = [[1,1], [1,-1], [-1,-1], [-1,1]]
    CONTIGOUS_NEIGHBOURS = [[0,1], [1,0], [-1,0], [0,-1]]

    attr_reader :bomb, :flagged, :value, :grid_size

    def initialize(position, grid_size)
        @position = position

        @grid_size = grid_size
        @max_index = grid_size - 1

        @bomb = false
        @flagged = false
        @revealed = false
    end

    def display
        return :B if @bomb && @revealed
        return :X if @flagged
        return :O if @revealed
        return :Z
    end

    def place_bomb
        @bomb = true
    end

    def flag_position
        if @flagged == false
            @flagged = true
        else
            @flagged = false
        end
    end

    def reveal_position
        @revealed = true
    end

    def neighbor_positions #=> Returns an array of the neigbouring-positions
        all_possible_neighbours = CONTIGOUS_NEIGHBOURS + DIAGIONAL_NEIGHBOURS
        neighbours = []

        all_possible_neighbours.each do |neighbour|
            x,y = (@position[0] + neighbour[0]), (@position[1] + neighbour[1])
            neighbour_position = [x,y]

            neighbours << neighbour_position if neighbour_on_grid(neighbour_position)
        end

        p neighbours
    end

    def neighbour_on_grid(neighbour_position)
        neighbour_position.all? {|coordinate| coordinate.between?(0, @max_index)}
    end
end