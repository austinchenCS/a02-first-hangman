defmodule GameState do
  defstruct game_state: :initializing,
            turns_left: 7,
            letters: [],
            used: [],
            last_guess: ""
end

defmodule Hangman.Game do

  def new_game() do
    word = Dictionary.random_word()
    |> String.codepoints()

    %GameState{letters: word} =
      struct(%GameState{}, letters: word)
  end

  def tally(game) do
    disp_letters = build_letters_state(game.letters, game.used)
    %{
      game_state: game.game_state,
      turns_left: game.turns_left,
      letters: disp_letters,
      used: game.used
    }

  end

  # Only shows letter in current board state if letter is found in "used"
  def show_letter(true, letter), do: letter
  def show_letter(false, letter), do: "_"

  # Takes the current state of the board and displays letters only if found in "used" list.
  def build_letters_state([], used), do: []
  def build_letters_state([ h | t ], used) do
    [ (h in used) |> show_letter(h) | t |> build_letters_state(used) ]
  end

  # def make_move(game, letter) do
  #   # Check if letter exists within game_state
  #   # If yes, :already_used
  #   # If No,
  #   #   -> Check word. If exists within word, :good_guess and word is not
  #   # If yes,
  #   #   -> Check word. If it does not exist within word, :bad_guess

  #   already_used(game.guess_state, l)
  #   already_used(game.guess_state, l)



  # end

  # defp already_used(list, letter), do: letter in list

  # # function_to_call(true, ____)
  # # function_to_call(false, ____)

  # def update_state() do
  #   is_duplicate

  # end

  # def is_duplicate(letter, letter),      do: :already_used
  # def is_duplicate(letter, diff_letter), do:

  # def check_guess([h | t], letter) do
  #     [ is_duplicate(h, letter) | check_duplicate(t) ]
  # end


end
