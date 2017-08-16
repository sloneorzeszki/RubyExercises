require_relative 'messages'
require_relative 'board'
require_relative 'player'
require_relative 'piece'
require_relative 'helpers'
require_relative 'move'
require 'pry'
require 'pry-nav'

class Game
  include Helpers
  include Messages
  attr_accessor :board, :players

  def initialize
    msg_welcome_message
    @board   = create_board
    @players = create_players
  end

  def run_game
    @players.cycle do |player|
        make_a_move(player)
    end
  end

  private

    def create_players
      players = []
      ["white", "black"].each do |color|
        msg_enter_player_name(color)
        name = gets.chomp
        players.push(Player.new(name, color))
      end
      players
    end

    def create_board
      board = Board.new
      @board_sq = board.squares
      board
    end

    def make_a_move(player)
      move = Move.new(player, @board_sq)
      @board.squares = move.board
      @board.graphical_display
    end
end

# @@chess=Game.new
# @@chess.run_game