defmodule GameState do
  defstruct game_state: :initializing,
            turns_left: 7,
            letters: [],
            used: ["e"],
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
    #IO.puts(game.letters)
    disp_letters = build_board(game.letters, game.used)

    # %{
    #   game_state: game.game_state,
    #   turns_left: game.turns_left,
    #   letters: disp_letters,
    #   used: game.used
    # }

  end

  # def tester([h | t], stuff) do
  #   IO.puts(h)
  #   IO.puts(t)
  #   IO.puts(stuff)
  # end

  def return_letter(true, letter), do: letter
  def return_letter(false, letter), do: "_"

  def search_used(letter, used) do
    return_letter(letter in used, letter)
  end

  def build_board([ ], used), do: []
  def build_board([ h | t ], used) do
    [ search_used(h, used) | build_board(t, used) ]
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
