require './player'
require './grid'

class Game
    def initialize(name1, name2, rows, columns, grid = nil, player1_moves=nil, player2_moves=nil, counter = nil)
        if(grid== nil)
            @@grid = Grid.new(rows, columns)
            @rows = rows
            @columns = columns
            @@grid.build_grid
            @player1 = Player.new(name1, "⬤", @@grid)
            @player2 = Player.new(name2, "◯", @@grid)
            @counter = 1
        else
            @@grid = grid
            @rows = rows
            @columns = columns
            @player1 = Player.new(name1, "⬤", @@grid)
            @player2 = Player.new(name2, "◯", @@grid)
            @player1.getmoves(player1_moves)
            @player2.getmoves(player2_moves)
            @counter = counter

        end    
    end

    def start   
        puts("#{@player1.name}: #{@player1.sign}")
        puts("#{@player2.name}: #{@player2.sign}")
        @@grid.print_grid 
        puts ""
        print "#{@player1.name}: #{@player1.moves}\n"
        print "#{@player2.name}: #{@player2.moves}\n"
        while true   
            if @counter == 1
                move = @player1.play
                if move == "success"
                    @@grid.print_grid
                    puts " "
                    print "#{@player1.name}: #{@player1.moves}\n"
                    print "#{@player2.name}: #{@player2.moves}\n"
                    if @@grid.game_won(@player1.sign)
                        puts "Congradulations #{@player1.name}, You won!"
                        break
                    elsif @@grid.is_full
                        puts "Congradulations to both players. It's a draw!"
                        break
                    else
                        @counter = 2
                    end
                elsif move == "save"
                    out_file = File.new("save.txt", "w+")
                    out_file.puts("#{@player1.name}: #{@player1.moves}\n")
                    out_file.puts("#{@player2.name}: #{@player2.moves}\n")
                    out_file.puts("counter: #{@counter}\n")
                    out_file.puts("rows: #{@rows}\n")
                    out_file.puts("columns: #{@columns}\n")
                    out_file.puts("#{@@grid.grid}")
                    puts "The game is saved."
                    break
                end
            elsif @counter == 2
                move = @player2.play
                if move == "success"
                    @@grid.print_grid
                    puts " "
                    print "#{@player1.name}: #{@player1.moves}\n"
                    print "#{@player2.name}: #{@player2.moves}\n"
                    if @@grid.game_won(@player2.sign)
                        puts "Congradulations #{@player2.name}, You won!"
                        break
                    elsif @@grid.is_full
                        puts "Congradulations to both players. It's a draw!"
                        break
                    else
                        @counter = 1
                    end
                elsif move == "save"
                    out_file = File.new("save.txt", "w+")
                    out_file.puts("#{@player1.name}: #{@player1.moves}\n")
                    out_file.puts("#{@player2.name}: #{@player2.moves}\n")
                    out_file.puts("counter: #{@counter}\n")
                    out_file.puts("rows: #{@rows}\n")
                    out_file.puts("columns: #{@columns}\n")
                    out_file.puts("#{@@grid.grid}")
                    puts "The game is saved."
                    break
                end
            end
        end
    end
end