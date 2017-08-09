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
    run_game
  end

  def run_game
    @players.cycle do |player|
      begin
        binding.pry
        from = ask_for_move(player, "from")
        to = ask_for_move(player, "to")
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

    def ask_for_move(player, to_or_from)
      msg_ask_for_move(player, to_or_from)
      selected_address = gets.chomp.to_s
      binding.pry
      raise unless address_valid?(selected_address)
      selected_address
    end

    def make_a_move(from, to)
      binding.pry
      piece = @board[from.to_sym][:piece].dup unless @board[from.to_sym][:piece].nil?
      @board[to.to_sym][:piece] = piece
      @board[from.to_sym][:piece] = nil
    end

end


Game.new