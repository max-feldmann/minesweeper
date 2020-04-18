class Tile

    DIAGIONAL_NEIGHBOURS = [[1,1], [1,-1], [-1,-1], [-1,1]]
    CONTIGOUS_NEIGHBOURS = [[0,1], [1,0], [-1,0], [0,-1]]

    attr_reader :bomb, :flagged, :value, :board, :max_index

    def initialize(position, board)
        @position = position

        @board = board
        @max_index = board.grid_size - 1

        @bomb = false
        @flagged = false
        @revealed = false
    end

    def display
        return :B if @bomb && @revealed
        return :X if @flagged
        return "#{neighbour_bomb_count}" if @revealed && neighbour_bomb_count > 0
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
        return if @revealed || @flagged
        @revealed = true

        if neighbor_positions.none? {|neighbor| neighbor.bomb}
            neighbor_positions.each {|neighbor| neighbor.reveal_position}
        end
    end

    def neighbor_positions #=> Returns an array of the neigbouring-positions
        all_possible_neighbours = CONTIGOUS_NEIGHBOURS + DIAGIONAL_NEIGHBOURS
        neighbours = []

        all_possible_neighbours.each do |neighbour|
            # go through every possible position. Add them to the position indices of the tile you are looking at
            # check if the position you found is on the board
            # if so, add to neighbour-array
            x,y = (@position[0] + neighbour[0]), (@position[1] + neighbour[1])
            neighbour_position = [x,y]

            neighbours << @board[neighbour_position] if neighbour_on_grid(neighbour_position)
        end

        neighbours
    end

    def neighbour_on_grid(neighbour_position) #=> is neighbors coordinate btw. 0 and maximum index?
        neighbour_position.all? {|coordinate| coordinate.between?(0, @max_index)}
    end

    def neighbour_bomb_count
        bomb_count = 0
        neighbor_positions.each {|neighbour| bomb_count += 1 if neighbour.bomb}
        bomb_count
    end
end