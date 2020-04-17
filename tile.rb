class Tile

    attr_reader :bomb, :flagged, :value

    def initialize(position)
        @position = position

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

    end

end