class Stage

  attr_reader :doors, :losing_doors, :winning_door

  def initialize
    @doors = [1, 2, 3]
    @x = [' ', ' ', ' ']
    @winning_door = nil
    @losing_doors = [1, 2, 3]
    self.set_stage
  end

  def set_stage
    @winning_door = @losing_doors.delete_at(rand(0..2))
  end

  def select_alternative_door(chosen_door)
    @x[chosen_door - 1] = '*'
    if chosen_door == @winning_door
      door_to_remove = @losing_doors.delete_at(rand(0..1))
    else
      @losing_doors.delete(chosen_door)
      door_to_remove = @losing_doors.first
    end
    @doors.map! { |door| door == door_to_remove ? :- : door }
    door_to_remove
  end

  def show
    puts "--------------------------------------------------"
    puts "DOORS:   #{@doors[0]}#{@x[0]}   #{@doors[1]}#{@x[1]}   #{@doors[2]}#{@x[2]}"
    puts "--------------------------------------------------"
  end

end