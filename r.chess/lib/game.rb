require_relative 'messages.rb'
require_relative 'board.rb'
require_relative 'player.rb'
require_relative 'piece.rb'
require_relative 'helpers.rb'
require 'pry'
require 'pry-nav'

include Helpers

class Game
  include Messages
  attr_accessor :board, :players, :pieces, :player_white, :player_black

  def initialize
    msg_welcome_message
    create_board
    @players = create_players
    @pieces = create_pieces
    binding.pry
    run_game
  end

  def run_game
    @players.cycle do |player|
      begin
        msg_ask_for_move_from(player)
        from = ask_for_move
        msg_ask_for_move_to(player)
        to = ask_for_move
        make_a_move(from, to)
      rescue 
        msg_move_not_allowed
        retry
      end
    end
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
      board = Board.new
      @board = board.squares
    end

    def create_pieces
      create_pawns
      create_non_pawns
    end

      def create_pawns
        [["white", 2], ["black", 7]].each do |color, y| 
          (1..8).each { |x| @board[to_key([x, y])][:piece] = Pawn.new(color) } 
        end
      end

      def create_non_pawns
        #color and y value
        [["white", 1], ["black", 8]].each do |color, y| 
          [1, 8].each { |x| @board[to_key([x, y])][:piece] = Rook.new(color) } 
          [2, 7].each { |x| @board[to_key([x, y])][:piece] = Knight.new(color) } 
          [3, 6].each { |x| @board[to_key([x, y])][:piece] = Bishop.new(color) } 
          [4].each    { |x| @board[to_key([x, y])][:piece] = Queen.new(color) } 
          [5].each    { |x| @board[to_key([x, y])][:piece] = King.new(color) } 
        end
      end


    def ask_for_move
      selected_address = gets.chomp.to_s
      raise unless address_valid?(selected_address)
      selected_address
    end

    def address_valid?(address)
      ("a".."h").include?(address[0]) && address[1].to_i.between?(1,8)
    end

    def make_a_move(from, to)
      binding.pry
      piece = @board[from.to_sym][:piece].dup 
      @board[to.to_sym][:piece] = piece
      @board[from.to_sym][:piece] = nil
    end

    def move_allowed?(from, to)
      true
    end
end


Game.new