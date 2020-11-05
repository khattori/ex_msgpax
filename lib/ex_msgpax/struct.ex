defmodule ExMsgpax.Struct do
  # Structは外部エージェントの構造体データの表現
  defstruct [:name, :data]

  defimpl Msgpax.Packer do
    require ExMsgpax.Types
    import ExMsgpax.Types

    def pack(%ExMsgpax.Struct{name: name, data: data}) do
      data = Msgpax.pack! %{"name" => name, "data" => data}, iodata: false
      Msgpax.Ext.new(ext_type(:struct), data)
      |> Msgpax.Packer.pack()
    end
  end
end
