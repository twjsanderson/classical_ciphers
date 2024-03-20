defmodule ClassicalCiphersTest do
  use ExUnit.Case
  doctest ClassicalCiphers

  test "encode_caesar happy paths" do
    assert ClassicalCiphers.encode_caesar("hello") == {:ok, "khoor"}
    assert ClassicalCiphers.encode_caesar("a") == {:ok, "d"}
    assert ClassicalCiphers.encode_caesar("A") == {:ok, "D"}
    assert ClassicalCiphers.encode_caesar("Z") == {:ok, "C"}
    assert ClassicalCiphers.encode_caesar("a b") == {:ok, "d e"}
    assert ClassicalCiphers.encode_caesar("X zA") == {:ok, "A cD"}
  end
  test "decode_caesar happy paths" do
    assert ClassicalCiphers.decode_caesar("khoor") == {:ok, "hello"}
    assert ClassicalCiphers.decode_caesar("d") == {:ok, "a"}
    assert ClassicalCiphers.decode_caesar("D") == {:ok, "A"}
    assert ClassicalCiphers.decode_caesar("C") == {:ok, "Z"}
    assert ClassicalCiphers.decode_caesar("d e") == {:ok, "a b"}
    assert ClassicalCiphers.decode_caesar("A cD") == {:ok, "X zA"}
  end
  test "rot_thirteen happy paths" do
    assert ClassicalCiphers.rot_thirteen("hello") == {:ok, "uryyb"}
    assert ClassicalCiphers.rot_thirteen("uryyb") == {:ok, "hello"}
    assert ClassicalCiphers.rot_thirteen("ur yyb") == {:ok, "he llo"}
    assert ClassicalCiphers.rot_thirteen("urYy b") == {:ok, "heLl o"}
    assert ClassicalCiphers.rot_thirteen("ur   b") == {:ok, "he   o"}
    assert ClassicalCiphers.rot_thirteen("he   o") == {:ok, "ur   b"}
  end
end
