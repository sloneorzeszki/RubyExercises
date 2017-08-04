require_relative 'messages.rb'

class Game
  include Messages

  def initialize
    welcome_message
    @board = create_board
    @players = create_players
    @pieces = create_pieces
  end
  
  private

  def create_players
    puts "Enter player names"
  end

  def create_board
    @board = Board.new
  end

  def create_pieces

  end

end
