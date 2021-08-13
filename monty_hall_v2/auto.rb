class Auto

  def initialize
    @runs = 1
  end

  def select_door
    rand(1..3)
  end

  def switch_door?(alternate_door)
    return true while @runs.between?(1,100)
    return false while @runs.between?(101,200)
  end

  def replay?
    while @runs < 200
      @runs += 1
      return true
    end
    @runs = 1
    return false
  end

end