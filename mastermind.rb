class Game
  attr_accessor :maker, :breaker

  def initialize
    @maker = Codemaker.new
    @breaker = Codebreaker.new
  end
end

class Codemaker
  def generate_secret_pattern
    colors = ["yellow","red","green", "cyan", "blue", "magenta"]  
    secret_pattern = [colors[rand(6)],colors[rand(6)],colors[rand(6)],colors[rand(6)]]
  end

  def compare_patterns(guess_pattern)
    feedback = []
    
    guess_pattern.each_with_index do |peg,index|
      if peg == secret_pattern[index] 
        feedback << "red"
      elsif secret_pattern.any?{|x| x == peg}
        feedback << "white"
      end
    end
    puts feedback
  end

end


class Codebreaker
  def make_a_guess
    guess_pattern = gets.chomp.split()
    
  end
end

game = Game.new
game = Codemaker.new
code.generate_secret_pattern

code.compare_patterns

