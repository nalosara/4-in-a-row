require './game'
require './grid'

class Play
    def playgame
        puts "Welcome to 4-in-a-Row! The goal of the game to connect four pieces vertically,
        horizontally or diagonally in a row before the other player."
        puts "You can choose to play in a default grid, which is 6x7 or choose whichever grid dimensions suit you. However, these must
        be larger than the default grid and the number of rows and columns must not differ by more than 2 (e.g. 6x8, 9x9, 10x12 are fine,
        but 8x11 is not)."

        puts "If you already have a saved game, you can save game by inputting the word 'load', or start the new game by typing 'new' or 
        pressing enter: "
        command = gets.chomp

        if command == "load"
            puts"the game will be loaded"
            file = File.open("save.txt")
            file_data = file.readlines.map(&:chomp)
            index_p1_1 = file_data[0].index("[")
            index_p1_2 = file_data[0].index("]")
            p1_name = file_data[0][0,index_p1_1-2]
            p1_moves_str = file_data[0][index_p1_1, index_p1_2]
            p1_moves_split =  p1_moves_str.split("")
            p1_moves = []
            for i in p1_moves_split
                if i.to_i.to_s == i
                    p1_moves << i.to_i
                end
            end

            index_p2_1 = file_data[1].index("[")
            index_p2_2 = file_data[1].index("]")
            p2_name = file_data[1][0,index_p2_1-2]
            p2_moves_str = file_data[1][index_p2_1, index_p2_2]
            p2_moves_split =  p2_moves_str.split("")
            p2_moves = []
            for i in p2_moves_split
                if i.to_i.to_s == i
                    p2_moves << i.to_i
                end
            end
            
            counter = file_data[2][9].to_i
            rows = file_data[3][6].to_i
            columns = file_data[4][9].to_i
            grid = Grid.new(rows, columns)
            grid.build_grid

            i = 0
            if p1_moves.length() == p2_moves.length()
                while i < p1_moves.length()
                    grid.player_move(p1_moves[i]-1, "⬤")
                    grid.player_move(p2_moves[i]-1, "◯")
                    i = i + 1
                end
            else
                while i < p1_moves.length() - 1
                    grid.player_move(p1_moves[i]-1, "⬤")
                    grid.player_move(p2_moves[i]-1, "◯")
                    i = i + 1
                end
                grid.player_move(p1_moves[i]-1, "⬤")
            end

            game = Game.new(p1_name, p2_name, rows, columns, grid, p1_moves, p2_moves, counter)
            game.start

            while true
                puts "Would you like to play another game? If so, type yes!"
                reply = gets.chomp
                if reply == "yes"
                    game = Game.new(p2_name, p1_name, rows, columns)
                    game.start
                else
                    break
                end
            end
         
        else
            puts "Enter the name of the first player:"
            name1 = gets.chomp

            puts "Enter the name of the second player:"
            name2 = gets.chomp

            puts "Choose the length of the grid (number of rows). By clicking ENTER, the default length will be applied."
            rows = 6
            loop do
                input = gets.chomp
                if input.empty? or input.nil?
                break
                elsif input.to_i < 6
                puts "The length of the grid must be greater or equal to 6. Please input another length."
                else
                    rows = input.to_i
                break
                end
            end

            puts "Choose the height of the grid (number of columns). By clicking ENTER, the default height will be applied."
            columns  = 7
            loop do
                input = gets.chomp
                if input.empty? or input.nil?
                    break
                elsif input.to_i < 7 
                    puts "The height of the grid must be greater or equal to 7. Please input another height."
                elsif (input.to_i - rows).abs > 2
                    puts "The difference between the height and length must not be greater than 2. Please input another height."
                else
                    columns = input.to_i
                    break
                end
            end

            puts "You chose to play in a #{rows}x#{columns} grid. The game will now start. Good luck!" 
            game = Game.new(name1, name2, rows, columns)
            game.start
            while true
                puts "Would you like to play another game? If so, type yes!"
                reply = gets.chomp
                if reply == "yes"
                    game = Game.new(name2, name1, rows, columns)
                    game.start
                else
                    break
                end
            end

        end
    end
end




