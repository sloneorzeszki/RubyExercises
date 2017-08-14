require_relative 'messages.rb'
require_relative 'helpers.rb'
require 'pry'

class Move
  include Messages
  include Helpers

  def initialize(player, board)
    @player     = player
    @board      = board
    @from       = ask_for_move_details("from")
    @from_sq    = @board[@from.to_sym]
    @from_piece = @from_sq[:piece]
    @to         = ask_for_move_details("to")
    @to_sq      = @board[@to.to_sym]
    make_a_move if move_allowed?
  end

  def ask_for_move_details(from_or_to)
    begin
      msg_ask_for_move_details(@player, from_or_to)
      chosen_address = gets.chomp.to_s
      raise unless address_valid?(chosen_address)
    rescue
      msg_move_not_allowed
      retry
    end
    chosen_address
  end

  def address_valid?(add)
    ("a".."h").include?(add[0]) && add[1].to_i.between?(1,8)
  end

  def move_allowed?
    piece_same_color_as_player(@from_sq) &&
    within_possible_moves && #considering position of other pieces
    no_check_for_the_current_player? 
  end

  def piece_same_color_as_player(square)
    square[:piece].color ==  @player.color
  end

  def within_possible_moves
    #blank hash with moves in each direction
    moves = @from_piece.move_directions.product([[]]).to_h 

    if %w(Bishop Queen Rook).include?(@from_piece.class.to_s)
      keys_in_play = moves.keys
      (1..7).each do |distance|
        keys_in_play.each do |key|
          coords = moves[key].last.nil? ? @from_sq[:coords] : moves[key].last
          new_move = offset(coords, key, distance)
          moves[key] << new_move if move_possible?(new_move) 
        end
    binding.pry

        moves.keys.each do |key|
          keys_in_play << key unless moves[key][distance-1].nil?
        end
      end
    elsif %w(King Pawn Knight).include?(@from_piece.class.to_s)
      
    end
    moves
  end

  def move_possible?(move)
    square = @board[to_key(move)]
    !square.nil? && 
    within_board?(square) && 
    square[:piece].nil? && 
    !piece_same_color_as_player(square) 
  end

  private

  def make_a_move
    piece = @board[from.to_sym][:piece].dup unless @board[from.to_sym][:piece].nil?
    @board[to.to_sym][:piece] = piece
    @board[from.to_sym][:piece] = nil
  end
end