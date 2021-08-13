class Player

  def initialize
  end

  def select_door
    puts "Behind one of these doors is a brand new Tesla."
    puts "The rest are empty. Choose wisely."
    puts ""
    puts "Please select a Door. [Ex. `1`]"
    selected_door = nil
    while !selected_door
      response = gets.chomp
      if response.to_i.to_s != response || !response.to_i.between?(1,3)
        puts "Invalid input. Please try again."
      else
        selected_door = response.to_i
      end
    end
    selected_door
  end

  def switch_door?(alternate_door)
    puts ""
    puts "Would you like to switch to Door ##{alternate_door}? Enter `Y` or `N`"
    response = nil
    while !response
      response = gets.chomp
      if !['Y', 'N'].include?(response.upcase)
        puts "Invalid input. Please try again."
        response = nil
      end
    end
    response.upcase == 'Y'
  end

  def replay?
    response = nil
    while !response
      response = gets.chomp
      if !['Y', 'Q'].include?(response.upcase)
        puts "Invalid input. Please try again."
        response = nil
      end
    end
    response.upcase == 'Y'
  end

end