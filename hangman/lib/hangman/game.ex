defmodule GameState do
  defstruct game_state: :initializing,
            turns_left: 7,
            word_key: [],
            guess_state: [],
            used: [],
            last_guess: ""
end

defmodule Hangman.Game do

  def new_game() do
    word = Dictionary.random_word()
    |> String.codepoints()

    word_redact = List.duplicate("_", length(word))

    %GameState{word_key: word, guess_state: word_redact} =
      struct(%GameState{}, word_key: word, guess_state: word_redact)
  end

  def tally(game) do
    %{
      game_state: game.game_state,
      turns_left: game.turns_left,
      letters: game.guess_state,
      used: game.used
    }
  end


end
