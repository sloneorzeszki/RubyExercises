require_relative 'messages.rb'
require_relative 'board.rb'
require_relative 'player.rb'
require 'pry'

class Game
  include Messages

  def initialize
        msg_welcome_message
    @board = create_board
    @players = create_players
    @pieces = create_pieces
  end
  
  private

  def create_players
    [create_player("white"),create_player("black")]
  end

  def create_board
    @board = Board.new
  end

  def create_pieces

  end

  def create_player(color)
    msg_enter_player_name(color)
    name = gets.chomp
    self.instance_variable_set("@player_#{color}", Player.new(name, color))
  end
end

x=Game.new