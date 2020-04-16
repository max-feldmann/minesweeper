class Tile

    attr_accessor :bomb, :flagged, :value

    def initialize(position)
        @position = position

        @bomb = false
        @flagged = false
        @revealed = false

        @value = 0
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
        @flagged = true
    end

    def reveal_position
        @revealed = true
    end

    def neighbor_positions #=> Returns an array of the neigbouring-positions

    end

end