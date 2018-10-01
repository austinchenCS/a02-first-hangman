defmodule GameState do
  defstruct game_state: :initializing,
            turns_left: 7,
            letters: [],
            used: [],
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

  # Just in case someone plays the non-wrapper version. Return the game status.
  def tally( game = %GameState{ game_state: :won  } ), do: game
  def tally( game = %GameState{ game_state: :loss } ), do: game

  def tally(game) do
    # "Massage" the display list of letters by listing "_" for each character not guessed
    disp_letters = build_letters_state(game.game_state, game.letters, game.used)

    # Output game state
    %{
      game_state: game.game_state,
      turns_left: game.turns_left,
      letters: disp_letters,
      used: game.used,
      last_guess: game.last_guess
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
    [ h in used |> show_letter(h) | t |> transform_letters(used) ]
  end

  # Pass in a letter as current guess, and update game status as necessary.
  def make_move(game, guess) do
    updated_game = handle_guess(game, guess)
    updated_tally = tally(updated_game)

    {updated_game, updated_tally}
  end

  ##############################################################################
  # Duplication check, to see whether "guess" is already in use.
  ##################


  # START OF LOGIC. This initial handler function, while only wrapping "duplicate_check",
  # begins the tree of function calls that evaluates the appropriate state changes
  # given a certain guess.
  def handle_guess(game, guess) do
    duplicate_check(game, guess)
  end

  ##############################################################################
  # Duplication check, to see whether "guess" is already in use.
  ##################

  def duplicate_check(game, guess) do
    # Pattern match for duplicates.
    guess in game.used
    |> duplicate_found(game, guess)
  end

  # Duplicate found, STOPPING POINT
  def duplicate_found(true, game, _guess) do
    %GameState{ game | game_state: :already_used }
  end

  # No duplicates found, CONTINUE to loss_check
  def duplicate_found(false, game, guess) do
    loss_check(game, guess)
  end

  ##############################################################################
  # Game LOSS check, to see if current guess will lose the game.
  ##################

  # Check for loss
  def loss_check(game, guess) do
    guess not in game.letters
    |> loss_found(game.turns_left, game, guess)
  end

  # Lost, STOPPING POINT
  def loss_found(true, 1, game, guess) do
    %GameState{ game |
      game_state: :lost,
      turns_left: 0,
      used: [guess | game.used] |> Enum.sort() }
  end

  # NO Loss, CONTINUE on to win_check
  def loss_found(false, _, game, guess) do
    win_check(game, guess)
  end

  ##############################################################################
  # Game WIN check, to see if current guess will win the game.
  ##################

  # Check for win
  def win_check(game, guess) do
    # Step 1: update "used" with guess to evaluate win or not
    curr_used = [guess | game.used] |> Enum.sort()
    curr_letters = build_letters_state(:no_state, game.letters, curr_used)

    curr_letters == game.letters
    |> won(game, guess)
  end

  # Won, STOPPING POINT
  def won(true, game, guess) do
    %GameState{ game |
      game_state: :won,
      turns_left: game.turns_left,
      used: [guess | game.used] |> Enum.sort() }
  end

  # Not a win, CONTINUE to guess_evaluate
  def won(false, game, guess) do
    guess_evaluate(game, guess)
  end

  ##############################################################################
  # Good/Bad check, to see if the guessed move is "good" or "bad".
  ##################

  # Check if guess is in letter.
  def guess_evaluate(game, guess) do
    guess not in game.letters
    |> bad_guess(game, guess)
  end

  # BAD guess
  def bad_guess(true, game, guess) do
    %GameState{ game |
    game_state: :bad_guess,
    turns_left: game.turns_left - 1,
    used: [guess | game.used] |> Enum.sort(),
    last_guess: guess }
  end

  # GOOD guess (not a bad guess)
  def bad_guess(false, game, guess) do
    %GameState{ game |
    game_state: :good_guess,
    turns_left: game.turns_left,
    used: [guess | game.used] |> Enum.sort(),
    last_guess: guess }
  end

end
