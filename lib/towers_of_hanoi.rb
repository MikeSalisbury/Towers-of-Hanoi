# Towers of Hanoi
#
# Write a Towers of Hanoi game:
# http://en.wikipedia.org/wiki/Towers_of_hanoi
#
# In a class `TowersOfHanoi`, keep a `towers` instance variable that is an array
# of three arrays. Each subarray should represent a tower. Each tower should
# store integers representing the size of its discs. Expose this instance
# variable with an `attr_reader`.
#
# You'll want a `#play` method. In a loop, prompt the user using puts. Ask what
# pile to select a disc from. The pile should be the index of a tower in your
# `@towers` array. Use gets
# (http://andreacfm.com/2011/06/11/learning-ruby-gets-and-chomp.html) to get an
# answer. Similarly, find out which pile the user wants to move the disc to.
# Next, you'll want to do different things depending on whether or not the move
# is valid. Finally, if they have succeeded in moving all of the discs to
# another pile, they win! The loop should end.
#
# You'll want a `TowersOfHanoi#render` method. Don't spend too much time on
# this, just get it playable.
#
# Think about what other helper methods you might want. Here's a list of all the
# instance methods I had in my TowersOfHanoi class:
# * initialize
# * play
# * render
# * won?
# * valid_move?(from_tower, to_tower)
# * move(from_tower, to_tower)
#
# Make sure that the game works in the console. There are also some specs to
# keep you on the right track:
#
# ```bash
# bundle exec rspec spec/towers_of_hanoi_spec.rb
# ```
#
# Make sure to run bundle install first! The specs assume you've implemented the
# methods named above.

class TowersOfHanoi
  attr_reader :towers

  def initialize
    @towers = [[3, 2, 1],[],[]]
  end

  def play
    until won?
      render
      p 'What tower would you like to select a disc from?'
      from_tower = gets.chomp.to_i - 1
      p 'Where would you like to move the disc to?'
      to_tower = gets.chomp.to_i - 1
      @disc = @towers[from_tower].last
      if valid_move?(from_tower, to_tower)
        move(from_tower, to_tower)
      else
        raise 'That is not a valid move! Please choose tower 1, tower 2 or tower 3'
      end
    end
  end

  def render
    p @towers
  end

  def valid_move?(from_tower, to_tower)
    if (from_tower + 1 > 0 && from_tower < @towers.length) && (to_tower + 1 > 0 && to_tower < @towers.length)
      if (@towers[from_tower] != [] && @towers[to_tower] != []) && (@disc < @towers[to_tower].last)
        return true
      elsif @towers[from_tower] != [] && @towers[to_tower] == []
        return true
      else
        return false
      end
    else
      return false
    end
  end

  def move(from_tower, to_tower)
    @disc = @towers[from_tower].pop
    @towers[to_tower].push(@disc)
  end

  def won?
    if @towers[0] == [] && (@towers[1] == [3, 2, 1] || @towers[2] == [3, 2, 1])
      p "you've won!"
      return true
    end
  end
end

if  $PROGRAM_NAME == __FILE__
  TowersOfHanoi.new.play
end
