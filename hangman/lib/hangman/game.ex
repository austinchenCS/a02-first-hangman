defmodule GameState do
  defstruct game_state: :initializing,
            turns_left: 7,
            letters: [],
            used: ["e"],
            last_guess: ""
end

defmodule Hangman.Game do


  # Create a new game state
  def new_game() do
    # Pick a random word from the dictionary
    word = Dictionary.random_word()
    |> String.codepoints()

    # Initialize the game state utilizing the random word
    %GameState{letters: _word} = struct(%GameState{}, letters: word)
  end

  def tally(game) do
    # "Massage" the display list of letters by listing "_" for each character not guessed
    disp_letters = build_letters_state(game.game_state, game.letters, game.used)

    # Output game state
    %{
      game_state: game.game_state,
      turns_left: game.turns_left,
      letters: disp_letters,
      used: game.used
    }

  end

  # Display full word if game state is won or lost. Otherwise transform letters into current status
  def build_letters_state(:won,  letters, _used), do: letters
  def build_letters_state(:lost, letters, _used), do: letters
  def build_letters_state(_,     letters,  used), do: transform_letters(letters, used)

  # HELPER: Only shows letter in current board state if letter is found in "used"
  def show_letter(true, letter),   do: letter
  def show_letter(false, _letter), do: "_"

  # Takes the current state of the board and displays letters only if found in "used" list.
  def transform_letters([], _used), do: []
  def transform_letters([ h | t ], used) do
    [ (h in used) |> show_letter(h) | t |> transform_letters(used) ]
  end

  # Pass in a letter as current guess, and update game status as necessary.
  def make_move(game, letter) do
    # # Check if letter exists within game_state
    # # If yes, :already_used
    # # If No,
    # #   -> Check word. If exists within word, :good_guess and word is not
    # # If yes,
    # #   -> Check word. If it does not exist within word, :bad_guess

    # # THESE ARE THE THINGS I HAVE TO UPDATE:
    # #         game_state:                   :initializing,
    # #         turns_left:                   7,
    # #         letters:                      ["a", "_", "_", "_", "_"],
    # #         used:                         ["a"],
    # #         last_guess:                   "a"


    # ## DUUPLICATE GUESS
    # # Check if guessed letter is already in board
    # already_used(game.letters, letter)
    #   game_state: :already_used
    #   turns_left: same
    #   letters: same
    #   used: same
    #   last_guess: same

    # # check if guessed letter is in "used" pile
    #   already_used(game.used, letter)
    #   game_state: :already_used
    #   turns_left: same
    #   letters: same
    #   used: same
    #   last_guess: same

    # #



    # {updated_game, updated_tally}
  end

  defp already_used(list, letter), do: letter in list

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
