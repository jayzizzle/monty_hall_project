require 'byebug'
require 'colorize'
require_relative 'stage.rb'
require_relative 'player.rb'

class Game

  attr_reader :stage, :player

  def initialize
    @stage = Stage.new
    @player = Player.new

    @total_games = 0
    @total_games_won = 0

    @switch_games = 0
    @switch_games_won = 0

    @keep_games = 0
    @keep_games_won = 0

    self.play
  end

  def play

    puts "Welcome to the Monty Hall Problem.".yellow
    puts "Behind one door, is " + "$1M".green
    puts "The rest have nada. Choose wisely."
    self.stage.show
    available_doors = self.stage.doors.select { |ele| ele.is_a?(Integer) }
    chosen_door = self.player.choose_door(available_doors)
    system 'clear'
    puts "You have chosen Door ##{chosen_door}."
    self.stage.select_alternative_door(chosen_door)
    self.stage.show
    puts "I have removed one of the losing doors."
    puts "Check your confidence."
    if self.player.change_door?
      self.switch_outcome(chosen_door)
    else
      self.no_switch_outcome(chosen_door)
    end
    @total_games += 1
    self.print_scoreboard
    self.reset
    self.play
  end

  def switch_outcome(chosen_door)
    puts ""
    @switch_games += 1
    if chosen_door != self.stage.winning_door
      puts "All you do is win, win, win!"
      @total_games_won += 1
      @switch_games_won += 1
    else
      puts "Sorry, wrong door. Better luck next time."
    end
  end

  def no_switch_outcome(chosen_door)
    puts ""
    @keep_games += 1
    if chosen_door == self.stage.winning_door
      puts "All you do is win, win, win!"
      @total_games_won += 1
      @keep_games_won += 1
    else
      puts "Sorry, wrong door. Better luck next time."
    end
  end

  def print_scoreboard

    @switch_games == 0 ? switch = 0 : switch = (100 * @switch_games_won / @switch_games)
    @keep_games == 0 ? keep = 0 : keep = (100 * @keep_games_won / @keep_games)

    puts ""
    puts "Switch Wins:     #{@switch_games_won} / #{@switch_games} (#{switch}%)"
    puts "Non-Switch Wins: #{@keep_games_won} / #{@keep_games} (#{keep}%)"
    puts "Total Games Won: #{@total_games_won} / #{@total_games} (#{100 * @total_games_won/@total_games}%)"
    puts ""
    puts ""
  end

  def reset
    @stage = Stage.new
  end

end

# TEST CODE

game = Game.new