defmodule ExMsgpax.Exception do
  defexception name: "", message: ""
  def message(me), do: "#{me.name}: #{me.message}"
end
