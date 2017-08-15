require_relative 'messages.rb'
require_relative 'helpers.rb'
require 'pry'

class Move
  include Messages
  include Helpers

  attr_accessor :player, :board, :from

  def initialize(player, board)
    @player     = player
    @board      = board
    @from       = ask_for_move_details("from")
    @from_sq    = @board[@from.to_sym]
    @from_piece = @from_sq[:piece]
    @to         = ask_for_move_details("to")
    @to_sq      = @board[@to.to_sym]
    make_a_move if within_possible_moves?
  end

  def ask_for_move_details(from_or_to)
    begin
      msg_ask_for_move_details(@player, from_or_to)
      chosen_address = gets.chomp.to_s
      # raise unless address_valid?(chosen_address)
    rescue
      msg_move_not_allowed
      retry
    end
    chosen_address
  end

  def within_possible_moves?
    #blank hash with moves in each direction
    moves = @from_piece.move_directions.map { |dir| [dir, []] }.to_h
    all_permitted_moves = []

    if %w(Bishop Queen Rook).include?(@from_piece.class.to_s)
      keys_in_play = moves.keys
      (1..7).each do |distance|
        keys_in_play.each do |key|
          coords = moves[key].last.nil? ? @from_sq[:coords] : moves[key].last
          new_move = offset(coords, key)
          moves[key] << new_move if potential_move_allowed?(new_move) 
        end

        moves.keys.each do |key|
          keys_in_play << key unless moves[key][distance-1].nil?
        end
      end

    elsif @from_piece.instance_of?(Knight)
      potential_moves = offset(@from_sq[:coords], moves.keys)
      potential_moves.each { |new_move| all_permitted_moves << new_move if potential_move_allowed?(@board[to_key(new_move)])}

    elsif @from_piece.instance_of?(King)
      moves.keys.each do |key|
        new_move = offset(@from_sq[:coords], key)
        moves[key] << new_move if potential_move_allowed?(@board[to_key(new_move)]) 
      end

    elsif @from_piece.instance_of?(Pawn)
      moves.keys.each do |key|
        new_move = offset(@from_sq[:coords], key)
        moves[key] << new_move if potential_move_allowed?(@board[to_key(new_move)], key) 
      end

    end
    all_permitted_moves = moves.keys.map { |key|  moves[key] }.flatten(1)
    binding.pry
    all_permitted_moves.include?(to_coords(@to))
  end

  def potential_move_allowed?(square, key=nil)
    existing_square?(square) &&
    either_no_piece_or_opponents_color(square) &&
    causes_no_check_for_the_current_player? &&
    pawn_movement(key) if @from_piece.instance_of?(Pawn)
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
    binding.pry
    if key == "up_double" 
     if @from_piece.color == "white"
       @from_sq[:coords[1]] == 2 && @from_piece.first_move_done.nil?
     elsif @from_piece.color == "black"
       @from_sq[:coords[1]] == 7  && @from_piece.first_move_done.nil?
     end
    elsif (key == "up_right" || key == "up_left") && !@to_sq[:piece].nil?
      @to_sq[:piece].color != @from_piece.color
    end
  end

  private

  def make_a_move
    piece = @board[from.to_sym][:piece].dup unless @board[from.to_sym][:piece].nil?
    @board[to.to_sym][:piece] = piece
    @board[from.to_sym][:piece] = nil
  end
end