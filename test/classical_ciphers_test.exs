defmodule ClassicalCiphersTest do
  use ExUnit.Case
  doctest ClassicalCiphers

  test "encode_caesar happy paths" do
    assert ClassicalCiphers.encode_caesar("hello") == "khoor"
    assert ClassicalCiphers.encode_caesar("a") == "d"
    assert ClassicalCiphers.encode_caesar("A") == "D"
    assert ClassicalCiphers.encode_caesar("Z") == "C"
    assert ClassicalCiphers.encode_caesar("a b") == "d e"
    assert ClassicalCiphers.encode_caesar("X zA") == "A cD"
  end
  test "decode_caesar happy paths" do
    assert ClassicalCiphers.decode_caesar("khoor") == "hello"
    assert ClassicalCiphers.decode_caesar("d") == "a"
    assert ClassicalCiphers.decode_caesar("D") == "A"
    assert ClassicalCiphers.decode_caesar("C") == "Z"
    assert ClassicalCiphers.decode_caesar("d e") == "a b"
    assert ClassicalCiphers.decode_caesar("A cD") == "X zA"
  end
  test "rot_thirteen happy paths" do
    assert ClassicalCiphers.rot_thirteen("hello") == "uryyb"
    assert ClassicalCiphers.rot_thirteen("uryyb") == "hello"
    assert ClassicalCiphers.rot_thirteen("ur yyb") == "he llo"
    assert ClassicalCiphers.rot_thirteen("urYy b") == "heLl o"
    assert ClassicalCiphers.rot_thirteen("ur   b") == "he   o"
    assert ClassicalCiphers.rot_thirteen("he   o") == "ur   b"
  end
  test "encode_rail_fence happy paths" do
    assert ClassicalCiphers.encode_rail_fence("hey buffy") == "hbye ufyf"
  end
  test "decode_rail_fence happy paths" do
    assert ClassicalCiphers.decode_rail_fence("hbye ufyf") == "hey buffy"
  end
end
