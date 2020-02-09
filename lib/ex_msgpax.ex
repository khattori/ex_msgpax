defmodule ExMsgpax do
  @moduledoc """
  Documentation for ExMsgpax.
  """

  @doc """
  ## Examples
      iex> pack("hello")
      {:ok, <<165, 104, 101, 108, 108, 111>>}
  """
  def pack(data), do: Msgpax.pack(data, iodata: false)

  @doc """
  ## Examples
      iex> pack!(9999)
      <<205, 39, 15>>
  """
  def pack!(data), do: Msgpax.pack!(data, iodata: false)

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
end
