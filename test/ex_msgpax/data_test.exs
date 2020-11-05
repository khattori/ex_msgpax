defmodule ExMsgpax.Data.Test do
  use ExUnit.Case
  import ExMsgpax.Data

  doctest ExMsgpax.Data

  test "packing data is to extract the content of data" do
    # Dataのpackはcontentを取り出すだけ
    data = new("hello")
    assert ExMsgpax.pack!(data) == data.content
  end
end
