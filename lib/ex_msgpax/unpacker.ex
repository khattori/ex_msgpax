defmodule ExMsgpax.Unpacker do
  @behaviour Msgpax.Ext.Unpacker
  require ExMsgpax.Types
  import ExMsgpax.Types

  def unpack(%Msgpax.Ext{type: ext_type(:exception), data: data}) do
    {struct, data} = Msgpax.unpack!(data, ext: ExMsgpax.Unpacker)
    data = for {k, v} <- data, into: %{}, do: {String.to_atom(k), v}
    {:ok, struct!(String.to_atom(struct), data)}
  end

  def unpack(%Msgpax.Ext{type: ext_type(:datetime), data: data}) do
    {:ok, NaiveDateTime.from_iso8601!(data)}
  end

  def unpack(%Msgpax.Ext{type: ext_type(:date), data: data}) do
    {:ok, Date.from_iso8601!(data)}
  end

  def unpack(%Msgpax.Ext{type: ext_type(:time), data: data}) do
    {:ok, Time.from_iso8601!(data)}
  end

  def unpack(%Msgpax.Ext{type: ext_type(:tuple), data: data}) do
    {:ok, Msgpax.unpack!(data, ext: ExMsgpax.Unpacker) |> List.to_tuple()}
  end
end
