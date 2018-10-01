defmodule Hangman do
  @moduledoc """
  Documentation for Hangman.
  """

  @doc """

  API functions for Hangman game.

  ## Examples

      iex(1)> game = Hangman.new_game()
      %GameState{
        game_state: :initializing,
        last_guess: "",
        letters: ["b", "i", "g", "g", "e", "s", "t"],
        turns_left: 7,
        used: []
      }

      iex(2)> Hangman.tally(game)
      %{
        game_state: :initializing,
        last_guess: "",
        letters: ["_", "_", "_", "_", "_", "_", "_"],
        turns_left: 7,
        used: []
      }

      iex(3)> { game, tally } = Hangman.make_move(game, "a")
      {%GameState{
        game_state: :bad_guess,
        last_guess: "a",
        letters: ["b", "i", "g", "g", "e", "s", "t"],
        turns_left: 6,
        used: ["a"]
      },
      %{
        game_state: :bad_guess,
        last_guess: "a",
        letters: ["_", "_", "_", "_", "_", "_", "_"],
        turns_left: 6,
        used: ["a"]
      }}
  """
  defdelegate new_game, to: Hangman.Game
  defdelegate tally(game), to: Hangman.Game
  defdelegate make_move(game, guess), to: Hangman.Game

end
