defmodule ExMsgpax.Types do
  use Const

  enum ext_type do
    exception 0
    datetime 1
    date 2
    time 3
    tuple 4
  end
end
