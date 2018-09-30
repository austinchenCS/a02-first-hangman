defmodule HangmanTest do
  use ExUnit.Case
  doctest Hangman

  test "greets the world" do
    game = Hangman.new_game()
    Hangman.tally(game)
  end
end


#def apply([ h | t ]), do: [ handle_individual | apply(tail)]
