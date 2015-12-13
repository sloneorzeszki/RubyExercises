class Game
  attr_accessor :maker, :breaker 

  def initialize
    @maker = Codemaker.new
    @breaker = Codebreaker.new
  end

  def start_game
    puts "Please select if you want to be a code [b]reaker or [m]aker:"
    decision = gets.chomp
    if decision == "b" 
      breaker_routine
    elsif decision == "m"
      maker_routine
    else
      puts "Please select either \"m\" or \"b\"."
      start_game
    end
  end

  def maker_routine
    puts "You are a code breaker, the computer will try to guess your pattern.",
    "Possible colors are yellow, red, green, cyan, blue, magenta.",  
    "Please enter you combination of four colors with one blank space between each color:"
    @maker.select_secret_pattern
    loop do
      input = @breaker.computer_guess
      p input.join(' ')
      @maker.compare_patterns(input)
    end
  end

  def breaker_routine
    puts "There are four colors being randomly selected next to each other.",
    "You goal is to input what colors were drawn in what order. You have 10 tries.",
    "Possible colors are yellow, red, green, cyan, blue, magenta.",  
    "Please enter your combination with one blank space between each color:"
    @maker.generate_secret_pattern
    loop do
      input = @breaker.make_an_input
      @maker.compare_patterns(input)
    end
  end
end

class Codemaker
  def initialize
    @secret_pattern = []
    @tries = 1
  end

  def generate_secret_pattern
    colors = ["yellow","red","green", "cyan", "blue", "magenta"]  
    @secret_pattern = [colors[rand(6)],colors[rand(6)],colors[rand(6)],colors[rand(6)]]
  end

  def select_secret_pattern
     @secret_pattern = gets.chomp.split()
  end

  def compare_patterns(input_pattern)
    feedback = []
    temp_pattern = @secret_pattern.dup

    for i in 0..input_pattern.size - 1
      if input_pattern[i] == temp_pattern[i]
        feedback << "red"
        input_pattern[i] = nil
        temp_pattern[i] = nil
      end
    end

    for i in 0..input_pattern.size - 1
      if input_pattern[i] != nil && temp_pattern.any? {|x| x == input_pattern[i]}
        feedback << "white"
        temp_pattern[temp_pattern.index(input_pattern[i])] = nil
        input_pattern[i] = nil
      end
    end
    
    if feedback.count("red") == 4
      puts "YOU WON OH MY GOD OH-MY-GOD!!!"
      exit
    else
      if @tries == 10 
        puts "There are no tries left. GAME OVER."
        exit
      else
        p "Feedback: " + feedback.count("red").to_s + "x red and "\
          + feedback.count("white").to_s + "x white. You have #{10 - @tries} tries left. "\
          "Try again:"
        @tries += 1
      end
    end
  end
end


class Codebreaker
  def make_an_input
    input_pattern = gets.chomp.split()
  end

  def computer_guess
    colors = ["yellow","red","green", "cyan", "blue", "magenta"]  
    guess = [colors[rand(6)],colors[rand(6)],colors[rand(6)],colors[rand(6)]]
  end
end

game = Game.new
game.start_game

