class Stage

  attr_reader :switch, :selected_door, :alternate_door, :winning_door

  def initialize
    @selected_door = nil
    @winning_door = 0
    @alternate_door = 0
    @removed_door = 0
    @losing_doors = []
    @doors = [1, 2, 3]
    @switch = false
    set_stage
  end

  def set_stage
    all_doors = @doors.dup.shuffle!
    @winning_door = all_doors.pop
    @losing_doors = all_doors.sort
  end

  def set_doors(selected_door)
    @selected_door = selected_door
    if @selected_door == @winning_door
      @removed_door = @losing_doors.shuffle!.pop
      @alternate_door = @losing_doors.pop
    else
      @losing_doors.delete(selected_door)
      @removed_door = @losing_doors.pop
      @alternate_door = @winning_door
    end
    @doors[@selected_door - 1] = "#{@selected_door}".colorize(:yellow)
    @doors[@removed_door - 1] = 'X'.colorize(:red)
    show
    puts "Door ##{@removed_door} has been revealed to be empty.".colorize(:red)
    @alternate_door
  end

  def reveal(choice)
    if choice
      @selected_door, @alternate_door = @alternate_door, @selected_door
      @switch = true
    end
    if @alternate_door == winning_door
      @doors[@selected_door - 1] = 'X'.colorize(:red)
    else
      @doors[@alternate_door - 1] = 'X'.colorize(:red)
    end
    @doors[@winning_door - 1] = "#{@winning_door}".colorize(:green)
    show
  end

  def show
    system 'clear'
    puts ""
    puts "======================================="
    puts ""
    puts " ---------     ---------     ---------"
    puts " |       |     |       |     |       |"
    puts " |   #{@doors[0]}   |     |   #{@doors[1]}   |     |   #{@doors[2]}   |"
    puts " |       |     |       |     |       |"
    puts " |      '|     |      '|     |      '|"
    puts " |       |     |       |     |       |"
    puts " |       |     |       |     |       |"
    puts "-----------   -----------   -----------"
    puts "======================================="
    puts ""
    puts "You have selected Door #" + "#{@selected_door}".yellow if !@selected_door.nil?
    puts ""
  end

end