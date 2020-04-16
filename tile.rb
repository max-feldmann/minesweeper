class Tile

    attr_accessor :position, :bomb, :flagged, :value
    def initialize(position)
        @position = position
        @bomb = false
        @flagged = false
        @value = 0
    end

    def display
        return :B if @bomb
        return :X if @flagged
        return :O
    end

    def place_bomb
        @bomb = true
    end


end