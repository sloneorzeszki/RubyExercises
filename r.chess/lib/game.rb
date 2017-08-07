require_relative 'messages.rb'
require_relative 'board.rb'
require_relative 'player.rb'
require_relative 'piece.rb'
require_relative 'helpers.rb'
require 'pry'

class Game
  include Messages
  attr_accessor :board, :players, :pieces, :player_white, :player_black

  def initialize
    msg_welcome_message
    @board = create_board
    @players = create_players
    @pieces = create_pieces
  end


  private

    def create_players
      players = []
      ["white", "black"].each do |color|
        msg_enter_player_name(color)
        name = gets.chomp
        players.push(self.instance_variable_set("@player_#{color}", Player.new(name, color)))
      end
      players
    end

    def create_board
      @board = Board.new
    end

    def create_pieces
      create_pawns
      create_non_pawns
    end

      def create_pawns

      end

      def create_non_pawns
        [["white", 1], ["black", 8]].each do |color| 
          [1, 8].each { |col| @board.squares[Helpers.to_key([col, color[1]])][:piece] = Rook.new(color[0]) } #create rooks
          [1, 8].each { |col| @board.squares[Helpers.to_key([col, color[1]])][:piece] = Rook.new(color[0]) } #create rooks
          
        end
      end
end
