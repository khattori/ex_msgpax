defmodule ExMsgpax.Types.Test do
  use ExUnit.Case
  require ExMsgpax.Types
  import ExMsgpax.Types

  test "check the type code is opaque" do
    refute is_opaque(ext_type(:atom))
    refute is_opaque(15)
    assert is_opaque(16)
    assert is_opaque(16)
    assert is_opaque(127)
    refute is_opaque(128)
  end
end
