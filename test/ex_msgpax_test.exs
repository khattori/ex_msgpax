defmodule ExMsgpaxTest do
  use ExUnit.Case
  import ExMsgpax

  doctest ExMsgpax

  test "pack/unpack" do
    data = {1, 2, 3, {"foo", "bar"}}
    assert data == pack!(data) |> unpack!
    data = ~N[2020-02-09 12:34:56]
    assert data == pack!(data) |> unpack!    
    data = ~D[2020-02-09]
    assert data == pack!(data) |> unpack!    
    data = ~T[12:34:56]
    assert data == pack!(data) |> unpack!    
  end
end
