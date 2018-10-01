defmodule HangmanTest do
  use ExUnit.Case
  doctest Hangman

  test "Make sure Elixir is working..." do
    assert 1 + 2 + 3 + 4 == 4 + 3 + 2 + 1
  end

  test "Initialize game" do
    Hangman.new_game()
  end

  test "New game starts with :initializing status" do
    game = Hangman.new_game()
    assert game.game_state == :initializing
  end

  test "New game starts with 7 lives / turns left" do
    game = Hangman.new_game()
    assert game.turns_left == 7
  end

  test "New game starts with no used letters" do
    game = Hangman.new_game()
    assert game.used == []
  end

  test "New game starts with no last guess" do
    game = Hangman.new_game()
    assert game.last_guess == ""
  end

  test "Creates a tally" do
    game = Hangman.new_game()
    Hangman.tally(game)
  end

  test "Makes a move" do
    game = Hangman.new_game()
    { _game, _tally } = Hangman.make_move(game, "a")
  end

  test "Makes muliple moves" do
    game = Hangman.new_game()
    { _game, _tally } = Hangman.make_move(game, "a")
    { _game, _tally } = Hangman.make_move(game, "b")
  end

  test "Checks for duplicates in entry" do
    game = Hangman.new_game()
    { game, _tally } = Hangman.make_move(game, "a")
    { game, _tally } = Hangman.make_move(game, "a")

    assert game.game_state == :already_used
  end

  test "Game status is not :initializing after making a move" do
    game = Hangman.new_game()
    { game, _tally } = Hangman.make_move(game, "a")

    assert game.game_state != :initializing
  end


end

