module Messages
    def msg_welcome_message
      puts "Welcome everyone!"
    end

    def msg_enter_player_name(color)
      print "Enter player's name (#{color} set): "
    end

    def msg_move_not_allowed
      puts "This move is not allowed. Select again."
    end

    def msg_ask_for_move_from(player)
      print "#{player.name}, please select the piece to move: "
    end
    
    def msg_ask_for_move_to(player)
      print "#{player.name}, please select the target square: "
    end
end
