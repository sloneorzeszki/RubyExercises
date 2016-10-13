require 'jumpstart_auth'

class MicroBlogger
  attr_reader :client

  def initialize
    puts "Initializing..."
    @client = JumpstartAuth.twitter
  end

  def run 
    puts "Welcome to the JSL Twitter Client!"
    command = ""
    while command != "q"
      printf "enter command: "
      input = gets.chomp
      parts = input.split(" ")
      command = parts[0]
      case command 
        when 'q' then puts "Goodbye!"
        when 't' then tweet(parts[1..-1].join(" "))
        when 'elt' then everyones_last_tweet
        when 'dm' then dm(parts[1], parts[2..-1].join(" "))
        when 'spam' then spam_my_followers(parts[1..-1].join(" "))
        when 's' then shorten(parts[1])
        else
          puts "Sorry, I don't know how to #{command}"
      end
    end
  end

  def tweet(message)
    if message.size <= 140
      @client.update(message)
    else
      puts "Too long tweet!"
      exit
    end
  end

  def dm(target, message)
    puts "Trying to send #{target} this direct message:"
    puts message
    screen_names = followers_list
    if screen_names.include?(target)
      message = "d @#{target} #{message}"
      tweet(message)
    else
      puts "you can't do that, the man is not in your followers, you fool"
    end
  end

  def followers_list
    screen_names = @client.followers.collect { |follower| @client.user(follower).screen_name }
  end

  def spam_my_followers(message)
    followers = followers_list
    followers.each { |follower| tweet("d #{follower} #{message}") }
  end

  def everyones_last_tweet
    friends = @client.friends
    friends.each do |friend|
    #  puts friend.name + " said:"
     # puts friend.status.source
    end
  end

  def shorten(original_url)
    puts "Shortening this URL: #{original_url}"
  end
end


blogger = MicroBlogger.new
blogger.run
