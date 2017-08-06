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

    end


end

# x=Game.new