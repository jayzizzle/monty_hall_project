require 'byebug'
require 'colorize'
require_relative 'stage.rb'
require_relative 'player.rb'
require_relative 'auto.rb'

class Game

  def initialize
    @stage = Stage.new
    @player = nil

    @games_switching = 0
    @games_won_by_switching = 0

    @games_not_switching = 0
    @games_won_by_not_switching = 0

    display_welcome
    player_select
    play
  end

  def play
    @stage.show
    alternate_door = @stage.set_doors(@player.select_door)
    @stage.reveal(@player.switch_door?(alternate_door))
    result
    scoreboard
    reset
  end

  def result
    if @stage.selected_door == @stage.winning_door
      puts "Congratulations! Well played."
      @stage.switch ? tally_switch_win : tally_non_switch_win
    else
      puts "Sorry, you chose poorly."
      @stage.switch ? @games_switching += 1 : @games_not_switching += 1
    end
  end

  def reset
    puts "  Enter `Y` to play again, `Q` to quit.".colorize(:yellow)
    if @player.replay?
      @stage = Stage.new
      play
    else
      display_game_over
      return nil
    end
  end

  def tally_switch_win
    @games_switching += 1
    @games_won_by_switching += 1
  end

  def tally_non_switch_win
    @games_not_switching += 1
    @games_won_by_not_switching += 1
  end

  def scoreboard
    if @games_switching != 0
      switch_percentage = (100 * @games_won_by_switching / @games_switching)
    else
      switch_percentage = 0
    end
    if @games_not_switching != 0
      non_switch_percentage = (100 * @games_won_by_not_switching / @games_not_switching)
    else
      non_switch_percentage = 0
    end
    puts ""
    puts "======================================="
    puts "     Games won by switching : #{@games_won_by_switching} (#{switch_percentage}%)"
    puts "       Games switched total : #{@games_switching}"
    puts "---------------------------------------"
    puts " Games won by not switching : #{@games_won_by_not_switching} (#{non_switch_percentage}%)"
    puts "   Games not switched total : #{@games_not_switching}"
    puts "======================================="
    puts ""
  end

  def display_welcome
    system 'clear'
    puts ""
    puts "     WELCOME TO THE...".colorize(:green)
    puts "                          __           __          ____".colorize(:yellow)
    puts "   ____ ___  ____  ____  / /___  __   / /_  ____ _/ / /".colorize(:yellow)
    puts '  / __ `__ \/ __ \/ __ \/ __/ / / /  / __ \/ __ `/ / / '.colorize(:yellow)
    puts " / / / / / / /_/ / / / / /_/ /_/ /  / / / / /_/ / / /  ".colorize(:yellow)
    puts '/_/ /_/ /_/\____/_/ /_/\__/\__, /  /_/ /_/\__,_/_/_/   '.colorize(:yellow)
    puts "                          /____/ ".colorize(:yellow)
    puts "                      __    __             ".colorize(:yellow)
    puts "    ____  _________  / /_  / /__  ____ ___ ".colorize(:yellow)
    puts '   / __ \/ ___/ __ \/ __ \/ / _ \/ __ `__ \\'.colorize(:yellow)
    puts "  / /_/ / /  / /_/ / /_/ / /  __/ / / / / /".colorize(:yellow)
    puts ' / .___/_/   \____/_.___/_/\___/_/ /_/ /_/ '.colorize(:yellow)
    puts "/_/".colorize(:yellow)
    puts ""
    puts "                               PRESS `Enter` TO BEGIN".colorize(:green)
    puts ""
    STDIN.getc
  end

  def player_select
    puts "                         Enter `1` for Single Player."
    puts "                         Enter `2` for Simulation."
    get_player_type
  end

  def display_game_over
    puts ""
    puts "   ____ _____ _____ ___  ___     ____ _   _____  _____".colorize(:blue)
    puts '  / __ `/ __ `/ __ `__ \/ _ \   / __ \ | / / _ \/ ___/'.colorize(:magenta)
    puts " / /_/ / /_/ / / / / / /  __/  / /_/ / |/ /  __/ /    ".colorize(:magenta)
    puts ' \__, /\__,_/_/ /_/ /_/\___/   \____/|___/\___/_/     '.colorize(:blue)
    puts "/____/ ".colorize(:blue)
    puts "         Thanks for playing.".colorize(:green)
    puts ""
  end

  def get_player_type
    player_type = nil
    while !player_type
      response = gets.chomp
      if response.to_i.to_s != response || !response.to_i.between?(1,2)
        puts "Invalid input. Please try again."
      else
        @player = Player.new if response.to_i == 1
        @player = Auto.new if response.to_i == 2
        player_type = true
      end
    end
  end

end

game = Game.new