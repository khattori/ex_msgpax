defimpl Msgpax.Packer, for: NaiveDateTime do
  require ExMsgpax.Types
  import ExMsgpax.Types

  def pack(datetime) do
    Msgpax.Ext.new(ext_type(:datetime), to_string(datetime))
    |> Msgpax.Packer.pack()
  end
end

defimpl Msgpax.Packer, for: Date do
  require ExMsgpax.Types
  import ExMsgpax.Types

  def pack(date) do
    Msgpax.Ext.new(ext_type(:date), to_string(date))
    |> Msgpax.Packer.pack()
  end
end

defimpl Msgpax.Packer, for: Time do
  require ExMsgpax.Types
  import ExMsgpax.Types

  def pack(time) do
    Msgpax.Ext.new(ext_type(:time), to_string(time))
    |> Msgpax.Packer.pack()
  end
end

defimpl Msgpax.Packer, for: Tuple do
  require ExMsgpax.Types
  import ExMsgpax.Types

  def pack(tuple) do
    data =
      Tuple.to_list(tuple)
      |> Msgpax.pack!(iodata: false)
    Msgpax.Ext.new(ext_type(:tuple), data)
    |> Msgpax.Packer.pack()
  end
end
