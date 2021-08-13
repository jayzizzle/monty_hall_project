class Player

  def initialize

  end

  def choose_door(available_doors)
    puts "Please choose a door. Available options: #{available_doors}"
    choice = nil
    while choice == nil
      choice = gets.chomp
      if choice.to_i.to_s == choice && available_doors.include?(choice.to_i)
        choice = choice.to_i
      else
        choice = nil
        puts "Invalid choice. Please try again."
      end
    end
    choice
  end

  def change_door?
    puts "Would you like to switch doors? Type `Y` or `N`"
    choice = nil
    while choice == nil
      choice = gets.chomp.downcase
      case choice
      when 'y'
        return true
      when 'n'
        return false
      else
        choice = nil
        puts "Invalid choice. Please try again."
      end
    end
  end

end