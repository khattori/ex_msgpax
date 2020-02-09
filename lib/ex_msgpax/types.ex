defmodule ExMsgpax.Types do
  use Const

  enum ext_type do
    atom 0
    datetime 1
    date 2
    time 3
    tuple 4
    exception 5
  end
end
