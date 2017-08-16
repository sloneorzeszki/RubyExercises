require_relative 'messages'
require_relative 'helpers'
require 'pry'

class Move
  include Messages
  include Helpers

  attr_accessor :player, :board, :from, :to

  def initialize(player, board)
    @player     = player
    @board      = board
    @from       = ask_for_address("from")
    @to         = ask_for_address("to")
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

  def address_valid?(add, from_or_to)
    two_characters_long?(add) &&
    within_board?(add) &&
    color_or_empty?(from_or_to, @board, add)
  end

  def within_possible_moves?
    !from_piece.nil? && possible_moves.include?(to_coords(@to))
  end

  def possible_moves
    #blank hash with moves in each direction as keys
    moves = from_piece.move_directions.map { |dir| [dir, []] }.to_h
    all_permitted_moves = []

    if %w(Bishop Queen Rook).include?(from_piece.class.to_s)
      keys_in_play = moves.keys
      (1..7).each do |distance|
        keys_in_play.each do |key|
          coords = moves[key].last.nil? ? from_sq[:coords] : moves[key].last
          new_move = offset(coords, key)
          moves[key] << new_move if possible_move?(to_key(new_move)) 
        end
        moves.keys.each do |key|
          keys_in_play << key unless moves[key][distance-1].nil?
        end
      end
    elsif from_piece.instance_of?(Knight)
      knight_moves = offset(from_sq[:coords], moves.keys[0])
      knight_moves.each { |new_move| moves[moves.keys[0]] << new_move if possible_move?(new_move)}
    elsif from_piece.instance_of?(King)
      moves.keys.each do |key|
        new_move = offset(from_sq[:coords], key)
        moves[key] << new_move if possible_move?(new_move) 
      end
    elsif from_piece.instance_of?(Pawn)
      moves.keys.each do |key|
        new_move = offset(from_sq[:coords], key)
        moves[key] << new_move if possible_move?(new_move, key) 
      end
    end
    
    all_permitted_moves = moves.keys.map { |key|  moves[key] }.flatten(1)
    all_permitted_moves
  end

  def possible_move?(coords, key=nil)
    square = @board[to_key(coords)]
    existing_square?(square) &&
    either_no_piece_or_opponents_color(square) &&
    causes_no_check_for_the_current_player? &&
    (from_piece.instance_of?(Pawn) ? pawn_movement(key) : true)
  end

  def existing_square?(square)
    !square.nil?
  end

  def either_no_piece_or_opponents_color(square)
    square[:piece].nil? || square[:piece].color != @player.color
  end

  def causes_no_check_for_the_current_player?
    true
  end

  def pawn_movement(key)
    if key == "up_double" 
     if from_piece.color == "white"
      if from_sq[:coords][1] == 2 && from_piece.first_move_done.nil?
        from_piece.first_move_done = true
      end
     elsif from_piece.color == "black"
      if from_sq[:coords][1] == 7  && from_piece.first_move_done.nil?
        from_piece.first_move_done = true
      end
     end
    elsif (key == "up_right" || key == "up_left") 
      if !to_sq[:piece].nil?
        to_sq[:piece].color != from_piece.color
      end
    else
      true
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