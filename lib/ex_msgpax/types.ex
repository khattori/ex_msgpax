defmodule ExMsgpax.Types do
  use Const

  enum ext_type do
    atom 0
    naivedatetime 1
    date 2
    time 3
    tuple 4
    struct 5
    exception 6
  end

  @opaque_min_type_code 16
  @opaque_max_type_code 127

  #
  # 16 - 127 は Opaque なデータ型のために予約
  #
  defguard is_opaque(type) when type >= @opaque_min_type_code and type <= @opaque_max_type_code
end
