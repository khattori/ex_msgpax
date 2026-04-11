defmodule ExMsgpax do
  @moduledoc """
  Documentation for ExMsgpax.
  """
  require ExMsgpax.Types
  import ExMsgpax.Types

  @doc """
  ## Examples
      iex> pack("hello")
      {:ok, <<165, 104, 101, 108, 108, 111>>}
  """
  def pack(data) do
    ext_pack(data)
    |> Msgpax.pack(iodata: false)
  end

  @doc """
  ## Examples
      iex> pack!(9999)
      <<205, 39, 15>>
  """
  def pack!(data) do
    case pack(data) do
      {:ok, packed} -> packed
      {:error, exception} -> raise exception
    end
  end

  defp ext_pack(data) when is_struct(data) do
    cond do
      not is_nil(Msgpax.Packer.impl_for(data)) -> data
      is_exception(data) ->
        data = Msgpax.pack! %{"name" => data.__struct__, "data" => ext_pack(Map.from_struct(data)), "message" => Exception.message(data)}, iodata: false
        Msgpax.Ext.new(ext_type(:exception), data)
      true ->
        data = Msgpax.pack! %{"name" => data.__struct__, "data" => ext_pack(Map.from_struct(data))}, iodata: false
        Msgpax.Ext.new(ext_type(:struct), data)
    end
  end

  defp ext_pack(data) when is_list(data), do: Enum.map(data, &ext_pack/1)
  defp ext_pack(data) when is_map(data), do: Map.new(data, fn {k, v} -> {ext_pack(k), ext_pack(v)} end)
  defp ext_pack(data) when is_tuple(data), do: data |> Tuple.to_list() |> Enum.map(&ext_pack/1) |> List.to_tuple()
  defp ext_pack(data), do: data

  @doc """
  ## Examples
      iex> unpack(<<192>>)
      {:ok, nil}
  """
  def unpack(data), do: Msgpax.unpack(data, ext: ExMsgpax.Unpacker)

  @doc """
      iex> unpack!(<<195>>)
      true
  """
  def unpack!(data), do: Msgpax.unpack!(data, ext: ExMsgpax.Unpacker)

  @doc """
  ## Examples
      iex> is_packable?(123)
      true

      iex> is_packable?(%RuntimeError{})
      true

      iex> is_packable?(1..5)
      true

      iex> is_packable?(fn -> :ok end)
      false

      iex> is_packable?(1..5 |> Stream.take(1))
      false
  """
  def is_packable?(data) do
    not is_nil(Msgpax.Packer.impl_for(data))
    or is_struct(data) and data.__struct__ != Stream
  end
end
