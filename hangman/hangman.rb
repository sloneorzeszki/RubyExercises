class Game
  def new_or_load
    decision = ""
    puts "Do you want to start a (N)ew game or (L)oad a saved one?"
    until decision == "N" || decision == "L"
      decision = gets.chomp.upcase
      if decision == "N"
        new_game
      elsif decision == "L"
        load_game
      else
        puts "Please enter N for new game or L to load a saved one."
      end
    end
  end


  def new_game
    @counter = 0
    @letters_tried_arr =[]
    @secret_word = select_secret_word
    @dashed_word_arr = @secret_word.dup.split('').map {|x| x = "_"}
    start_game
    routine
  end


  def load_game
    if File.exists?('saved.txt')
      saved_par_arr = File.readlines('saved.txt')
      @counter = saved_par_arr[0].to_i
      @letters_tried_arr = saved_par_arr[1].split("")
      @secret_word = saved_par_arr[2]
      @dashed_word_arr = saved_par_arr[3].split("")
      routine
    else
      puts "There is no saved game. You need to start a new one."
      new_game
    end
  end

  def save_game
    File.write("saved.txt", "#{@counter}\n#{@letters_tried_arr.join}\n#{@secret_word}\n#{@dashed_word_arr.join}")
    puts "Game saved."
  end


  def select_secret_word
    dictionary = File.read("dict.txt").gsub("\n"," ").split(" ")
    secret_word = ""
    until secret_word.size.between?(5,12)
      secret_word = dictionary[rand(dictionary.size)]
    end
    secret_word
  end


  def start_game
    puts "Welcome to our game. If you do well, you get nothing. If you don't, you die."
    puts "To save the game, enter \"SAVE\" when prompted for a letter."
    puts "Try to guess the letters of the following word."
    puts "Secret word: " + @dashed_word_arr.join(" ")
  end


  def routine
   loop do
      letter_try = choose_letter
      replaced = replace_letters(letter_try)
      display_result
      update_counter(replaced)
      check_result
      display_counter
      
    end
  end


  def choose_letter
    letter_try = ""
    loop do 
      print "Please enter a letter: "
      letter_try = gets.chomp.downcase
      if (letter_try =~ /[A-Za-z]/) == 0 && letter_try.size == 1
        if @letters_tried_arr.any?{|x| x == letter_try}
          puts "You have already tried that one. Focus!"
        else
           @letters_tried_arr << letter_try
           break
        end
      elsif letter_try == "save"
        save_game
      else
        puts "Enter a l-e-t-t-e-r. One letter. Also, not digit."
      end
    end
    letter_try
  end


  def replace_letters(letter_try)
    replaced = false
    @secret_word.split('').each_with_index do |letter,index|
      if letter == letter_try
        @dashed_word_arr[index] = letter_try
        replaced = true
      end
    end
    replaced
  end


  def display_result
    puts "Result: " + @dashed_word_arr.join(" ")
  end


  def update_counter(replaced)
    if !replaced
      @counter += 1
    end
  end


  def check_result
    if @dashed_word_arr.any?{|x| x == "_"}
      if @counter == 10
        puts "You lost! Expected."
        exit
      end
    else
      puts "You won! Hmm.."
      exit
    end 
  end


  def display_counter
    puts "How dead you are: " + "X "*@counter + "-"*(10-@counter) + " (#{@counter}/10)"
  end
end

game = Game.new
game.new_or_load
