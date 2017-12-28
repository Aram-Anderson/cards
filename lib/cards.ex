defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards.
  """
  @doc """
  Returns a list of strings representing a standard deck of 52 cards
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end
  @doc """
  Randomly shuffles the deck of cards.
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end
  @doc """
  Checks if the `card` argument exists within the `deck` argument.

  ## Examples
      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true
      iex> Cards.contains?(deck, "Not a Card")
      false
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck. The `hand_size` argument indicates how many cards should be in the hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, _remaining_deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end
  @doc """
    Saves a deck to a system file in the file tree. The deck to be saved is the `deck` argument, and the `filename` argument is the name the file will be saved under.
  """
  def save(deck, filename) do
     binary = :erlang.term_to_binary(deck)
     File.write(filename, binary)
  end
  @doc """
    Loads a saved file representing a deck that was saved using the `save` function.
  """
  def load(filename) do
    case File.read(filename) do
       { :ok, binary } ->  :erlang.binary_to_term(binary)
       { :error, _reason } -> "That file does not exist"
     end
  end

  @doc """
  Calls `create_deck`, `shuffle`, and `deal`. The `hand_size` argument will be the `hand_size` argument passed to deal, determining how many cards will be delt.
  """

  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end

end
