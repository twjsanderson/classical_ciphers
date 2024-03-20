defmodule ClassicalCiphers do
  @moduledoc """
  Documentation for ClassicalCiphers
  1. caesar
    a) encode
    b) decode
  2. rot_thirteen (ROT 13)
  3. rail_fence
  """

  defp char_shift(char, shift, code) when char in ?a..?z or char in ?A..?Z or char == 32 do
    case code do
      # shift lowercase forward
      :encode when char in ?a..?z -> ?a + rem(char - ?a + shift, 26)
      # shift uppercase forward
      :encode when char in ?A..?Z -> ?A + rem(char - ?A + shift, 26)
      # shift lowercase backward
      :decode when char in ?a..?z ->
        shift_char = char - shift
        if shift_char < ?a do
          ?z - (?a - shift_char - 1)
        else
          shift_char
        end
      # shift uppercase backward
      :decode when char in ?A..?Z ->
        shift_char = char - shift
        if shift_char < ?A do
          ?Z - (?A - shift_char - 1)
        else
          shift_char
        end
      _ -> char
    end
  end

  defp text_shift(text, shift, code) do
    text_length_limit = 2000
    if byte_size(text) < 1 || byte_size(text) > text_length_limit do
      raise ArgumentError, message: "text length must be <= #{text_length_limit} and > 0"
    end
    {
      :ok,
      text
        |> String.to_charlist()
        |> Enum.map(&char_shift(&1, shift, code))
        |> to_string()
    }
  end

  @doc """
  Caesar Cipher

  ## Examples

      iex> ClassicalCiphers.encode_caesar("hello")
      {:ok, "khoor"}

      iex> ClassicalCiphers.decode_caesar("khoor")
      {:ok, "hello"}

  """
  def encode_caesar(text) when is_binary(text) do
    text_shift(text, 3, :encode)
  end

  def decode_caesar(text) when is_binary(text) do
    text_shift(text, 3, :decode)
  end

  @doc """
  rot_thirteen (Rot 13) Cipher

  ## Examples

      iex> ClassicalCiphers.rot_thirteen("hello")
      {:ok, "uryyb"}

      iex> ClassicalCiphers.rot_thirteen("uryyb")
      {:ok, "hello"}

  """
  def rot_thirteen(text) when is_binary(text) do
    text_shift(text, 13, :encode)
  end

  # TODO: implement rail_fence cipher
  # 1. create empty matrix height is # of rails, width is length of text
  # 2. enumerate over it? start at 0,0 of matrix at first char of text
  # 3. increase row and col by 1 (ie. [1, 1]) add next char of text
  # 4. if row == rails (ie. last row), then subtract row (if 3 rows at [2, 2], next would be [1, 3])
  # 5. if row == 0 (ie. first row), then add row again (if back to first row [0, 4], next would be [1, 5])
  # def rail_fence(text, rails \\ 3) do
  #   text_length = byte_size(text)
  #   matrix = Matrix.create(rails, text_length)
  # end

end
