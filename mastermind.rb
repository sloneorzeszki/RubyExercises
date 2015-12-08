class Game
  attr_accessor :maker, :breaker, :tries

  def initialize
    @maker = Codemaker.new
    @breaker = Codebreaker.new
    @tries = 1
    puts "There are four colors being randomly selected next to each other.",
    "You goal is to guess what colors were drawn in what order. You have 10 tries.",
    "Possible colors are yellow, red, green, cyan, blue, magenta.",  
    "Please enter you combination with one blank space between each color:"
  end

end

class Codemaker
  def initialize
    @secret_pattern = []
  end
  
  def generate_secret_pattern
    colors = ["yellow","red","green", "cyan", "blue", "magenta"]  
    @secret_pattern = [colors[rand(6)],colors[rand(6)],colors[rand(6)],colors[rand(6)]]
  end

  def compare_patterns(guess_pattern)
    feedback = []
    temp_pattern = @secret_pattern.dup

    for i in 0..guess_pattern.size - 1
      if guess_pattern[i] == temp_pattern[i]
        feedback << "red"
        guess_pattern[i] = nil
        temp_pattern[i] = nil
      end
    end

    for i in 0..guess_pattern.size - 1
      if guess_pattern[i] != nil && temp_pattern.any? {|x| x == guess_pattern[i]}
        feedback << "white"
        temp_pattern[temp_pattern.index(guess_pattern[i])] = nil
        guess_pattern[i] = nil
      end
    end

    if feedback.count("red") == 4
      puts "YOU WON OH MY GOD OH-MY-GOD!!!"
      exit
    elsif
      if @tries == 10 
        puts "There are no tries left. GAME OVER."
        exit
      elsif
        puts "Feedback: " + feedback.count("red").to_s + "x red and "\
              + feedback.count("white").to_s + "x white. You have #{10 - @tries} tries left."
               "Try again:"
        @tries += 1
      end
    end
  end
end


class Codebreaker
  def make_a_guess
    guess_pattern = gets.chomp.split()
  end
end

game = Game.new
game.maker.generate_secret_pattern

loop do
  guess = game.breaker.make_a_guess
  game.maker.compare_patterns(guess)
end
