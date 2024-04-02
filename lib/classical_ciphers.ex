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
    text
      |> String.to_charlist()
      |> Enum.map(&char_shift(&1, shift, code))
      |> to_string()
  end

  @doc """
  Caesar Cipher

  ## Examples

      iex> ClassicalCiphers.encode_caesar("hello")
      "khoor"

      iex> ClassicalCiphers.decode_caesar("khoor")
      "hello"

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
      "uryyb"

      iex> ClassicalCiphers.rot_thirteen("uryyb")
      "hello"

  """
  def rot_thirteen(text) when is_binary(text) do
    text_shift(text, 13, :encode)
  end

  @doc """
  encode_rail_fence Cipher

  ## Examples

      iex> ClassicalCiphers.encode_rail_fence("hey buffy")
      "hbye ufyf"

  """
  def encode_rail_fence(text, rails \\ 3) do
    Enum.concat(1..(rails - 1), rails..2)
      |> Stream.cycle()
      |> Stream.zip(String.graphemes(text))
      |> Enum.sort_by(fn {rail, _} -> rail end)
      |> Enum.map(fn {_, char} -> char end)
      |> Enum.join("")
  end

  defp gen_cycle(rails) do
    Enum.to_list(0..rails - 1) ++ :lists.seq(rails - 2, 0, -1)
  end

  defp gen_pattern(text, rails) do
    rails
      |> gen_cycle()
      |> Enum.slice(0..-2 // 1)
      |> List.duplicate(String.length(text))
      |> List.flatten()
  end

  @doc """
  decode_rail_fence Cipher

  ## Examples

      iex> ClassicalCiphers.decode_rail_fence("hbye ufyf")
      "hey buffy"

  """
  def decode_rail_fence(text, rails \\ 3) do
    pattern =
      text
        |> gen_pattern(rails)
        |> Enum.take(String.length(text))
        |> Enum.zip(0..String.length(text))
        |> Enum.sort_by(&elem(&1, 0))
    positions = Enum.map(pattern, &elem(&1, 1))
    text
      |> String.codepoints()
      |> Enum.zip(positions)
      |> Enum.sort_by(&elem(&1, 1))
      |> Enum.map_join(&elem(&1, 0))
  end

end
