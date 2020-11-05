defmodule ExMsgpax.Unpacker do
  @behaviour Msgpax.Ext.Unpacker
  require ExMsgpax.Types
  import ExMsgpax.Types

  def unpack(%Msgpax.Ext{type: ext_type(:atom), data: data}) do
    {:ok, String.to_atom(data)}
  end

  def unpack(%Msgpax.Ext{type: ext_type(:naivedatetime), data: data}) do
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

  def unpack(%Msgpax.Ext{type: ext_type(:struct), data: data}) do
    #
    # nameに対応する構造体が定義されていない場合、Structデータを返す
    #
    case Msgpax.unpack!(data, ext: ExMsgpax.Unpacker) do
      %{"name" => name, "data" => data} when is_atom(name) ->
        try do
          {:ok, struct(name, data)}
        rescue
          UndefinedFunctionError -> {:ok, %ExMsgpax.Struct{name: name, data: data}}
        end
      %{"name" => name, "data" => data} ->
        {:ok, %ExMsgpax.Struct{name: name, data: data}}
    end
  end

  def unpack(%Msgpax.Ext{type: ext_type(:exception), data: data}) do
    #
    # 定義されていない例外の場合、Exceptionデータを返す
    #
    case Msgpax.unpack!(data, ext: ExMsgpax.Unpacker) do
      %{"name" => name, "data" => data} ->
        {:ok, struct(name, data)}
      %{"name" => name, "message" => message} ->
        {:ok, %ExMsgpax.Exception{name: name, message: message}}
    end
  end

  def unpack(%Msgpax.Ext{} = ext), do: {:ok, ext}
end
