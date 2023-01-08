require './grid'
class Player
    def initialize(name, sign, grid)
        @name = name
        @sign = sign
        @grid = grid
        @moves = []
    end

    def play
        move = "fail"
        puts""
        puts "Player #{@name} enter the column you'd like to insert your token. If you want to save the game, write save."
        column  = gets.chomp
        if column == "save"
            move = "save"
        elsif column.to_i > @grid.columns || column.to_i < 1 
            puts "The column you chose doesn't exist on this grid"
        else
            inserted = @grid.player_move(column.to_i - 1, @sign)
        end
        if inserted
            move  = "success"
            @moves << column.to_i
        end
        return move
    end

    def name
        return @name
    end

    def sign
        return @sign
    end

    def moves
        return @moves
    end

    def getmoves(moves)
        @moves = moves
    end
end