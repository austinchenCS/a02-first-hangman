defmodule Hangman do
  @moduledoc """
  Documentation for Hangman.
  """

  @doc """

  API functions for Hangman game.
  """
  defdelegate new_game, to: Hangman.Game
  defdelegate tally(game), to: Hangman.Game
  defdelegate make_move(game, guess), to: Hangman.Game

end
