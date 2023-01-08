class Grid
    def initialize(rows, columns)
        @@rows = rows
        @@columns = columns
        @@grid = []
    end

    def rows
        return @@rows
    end

    def columns 
        return @@columns
    end

    def grid
        return @@grid
    end
    
    def build_grid
        @@rows.times do |row|
            @@grid[row] = []
    
            @@columns.times do
                @@grid[row] << '_'
            end
        end
    end
    
    def print_grid
        i = 1
        for row in @@grid
            print i
            print " "
            print "|"
            for col in row
                print " #{col}  "
                print "|"
            end
            puts "\n" 
            i = i + 1
        end
        for row in @@grid
            i = 1
            for col in row
                print " "
                print " "
                print " " 
                print " "
                print i
                i = i + 1
            end
            break
        end      
    end

    def player_move(column, player)
    inserted = false
        row = self.find_row(column)
        if row == -1
            puts "The column you chose is already full!"
        else
            @@grid[row][column] = player
            inserted = true
        end
        return inserted
    end

    def find_row(column)
        row = @@rows - 1
        while @@grid[row][column]!= '_'
            if row < 0
                return -1
            else
                row = row - 1
            end
        end
        return row
    end

    def game_won(player)
        i = 0
        while i < @@rows
            j = 0
            while j <  @@columns - 3
                if(@@grid[i][j] == @@grid[i][j + 1] && @@grid[i][j] == @@grid[i][j + 2] && @@grid[i][j] == @@grid[i][j + 3] && @@grid[i][j] == player)
                    return true
                end
                j = j + 1
            end
            i = i + 1
        end

        for row in @@grid
            j = 0
            while j <  @@columns
                i = 0
                while i< row.length() - 4
                    if(@@grid[i][j] == @@grid[i + 1][j] && @@grid[i][j] == @@grid[i + 2][j] && @@grid[i][j] == @@grid[i + 3][j] && @@grid[i][j] == player)
                        return true
                    end
                    i = i + 1
                end
            j = j + 1
            end
        end

        diagonal_rows = @@rows - 3
        diagonal_columns = @@columns - 3

        i = 0
        while i < diagonal_rows
            j = 0
            while j < diagonal_columns
                if(@@grid[i][j] == @@grid[i+1][j+1] && @@grid[i][j] == @@grid[i+2][j+2] && @@grid[i][j] == @@grid[i+3][j+3] && @@grid[i][j] == player)
                    return true
                end
                j = j + 1
            end
            i = i + 1
        end

        i = @@rows - 1
        while i > 2
            j = 0
            while j < diagonal_columns
                if(@@grid[i][j] == @@grid[i-1][j+1] && @@grid[i][j] == @@grid[i-2][j+2] && @@grid[i][j]  == @@grid[i-3][j+3] && @@grid[i][j] == player)
                    return true
                end
                j = j + 1
            end
            i = i - 1
        end
        return false
    end

    def is_full()
        for row in @@grid
            for col in row
                if col.include?("_")
                    return false
                end
            end
        end
        return true
    end

    def grid
        return @@grid
    end
end