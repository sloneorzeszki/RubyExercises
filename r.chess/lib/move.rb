require_relative 'messages'
require_relative 'helpers'
require 'pry'

class Move
  include Messages
  include Helpers

  attr_accessor :player, :board, :from, :to

  def initialize(player, board)
    @player  = player
    @board   = board
    @from    = ask_for_address("from")
    @to      = ask_for_address("to")
    apply_the_move if within_possible_moves?
  end

  def ask_for_address(from_or_to)
    begin
      msg_ask_for_address(@player, from_or_to)
      address = gets.chomp.to_s
      raise msg_not_valid_address unless address_valid?(address, from_or_to)
    rescue 
      retry
    end
    address
  end

  def address_valid?(address, from_or_to)
    two_characters_long?(address) &&
    within_board?(address) &&
    color_or_empty?(from_or_to, @board, address, @player)
  end

  def within_possible_moves?
    !from_piece.nil? && possible_moves.include?(to_coords(@to))
  end

  #calculate all @from offsets (depending on piece type) and filter valid moves only
  def possible_moves
    #blank hash with move names in each direction as keys
    moves = from_piece.move_directions.map { |dir| [dir, []] }.to_h
    piece_type = from_piece.class.to_s

    case piece_type
    when "Bishop", "Queen", "Rook"
      keys_in_play = moves.keys
      (1..7).each do |distance| #maximum 7 squares long move
        keys_in_play.each do |key|
          coords = moves[key].last.nil? ? from_sq[:coords] : moves[key].last
          new_move = offset(coords, key)
          moves[key] << new_move if possible_move?(to_key(new_move)) 
        end
        #eliminate keys from further calculations if no moves were returned for them in latest iteration
        moves.keys.each do |key|
          keys_in_play << key unless moves[key][distance-1].nil?
        end
      end
    when "King", "Pawn"
      list_possible_moves(moves)
    when "Knight"
      offset(from_sq[:coords], moves.keys[0]).each do |new_move| 
        moves[moves.keys[0]] << new_move if possible_move?(new_move)
      end
    end
    
    moves.keys.map { |key| moves[key] }.flatten(1)
  end

  def list_possible_moves(moves)
    moves.keys.each do |key|
      new_move = offset(from_sq[:coords], key)
      moves[key] << new_move if possible_move?(new_move, key) 
    end
  end

  def possible_move?(coords, key=nil)
    square = @board[to_key(coords)]
    existing_square?(square) &&
    either_no_piece_or_opponents_color(square, player) &&
    causes_no_check_for_the_current_player? &&
    (!key.nil? ? pawn_logic(key, square) : true)
  end

  def pawn_logic(key, square)
    from_piece.first_move = false if from_piece.first_move

    case key
    when "up_double"
      from_sq[:coords][1] == 2 
    when "down_double" 
      from_sq[:coords][1] == 7
    when "up_right", "up_left", "down_right", "down_left" 
      square[:piece].color != from_piece.color if !square[:piece].nil?
    when "up", "down"
      square[:piece].nil?
    end
  end

  def apply_the_move
    to_sq[:piece] = from_piece
    from_sq[:piece] = nil
    @board
  end

  private

    def from_sq
      @board[@from.to_sym]
    end

    def from_piece
      from_sq[:piece] 
    end

    def to_sq
      @board[@to.to_sym]
    end
    
    def to_piece
      to_sq[:piece]
    end
end