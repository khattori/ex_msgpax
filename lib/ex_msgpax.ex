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
    ext_pack(data)
    |> Msgpax.pack!(iodata: false)
  end

  defp ext_pack(data) do
    if Exception.exception? data do
      data = Msgpax.pack! %{"name" => data.__struct__, "message" => Exception.message(data)}, iodata: false
      Msgpax.Ext.new(ext_type(:exception), data)
    else
      data
    end
  end

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

      iex> is_packable?(fn -> :ok end)
      false
  """
  def is_packable?(data) do
    not is_nil(Msgpax.Packer.impl_for(data)) or Exception.exception?(data)
  end
end
